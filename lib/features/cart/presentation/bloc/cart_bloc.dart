import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:test_eccomarce/features/cart/data/models/cart_model.dart';
import 'package:test_eccomarce/shared/models/product_model.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(const CartState(cart: Cart(items: []))) {
    on<AddCartItem>(_onAddCartItem);
    on<DecreaseQuantityItem>(_onDecreaseQuantityItem);
    on<RemoveCartItem>(_onRemoveCartItem);
    on<ClearCart>(_onClearCart);
    on<AddProductsToCart>(_onAddProductsToCart);
  }

  void _onAddCartItem(AddCartItem event, Emitter<CartState> emit) {
    final updatedCart = List<CartItem>.from(state.cart.items ?? []);
    final index = updatedCart.indexWhere(
      (item) => item.product.id == event.item.product.id,
    );

    if (index != -1) {
      final existingItem = updatedCart[index];
      updatedCart[index] = existingItem.copyWith(
        quantity: existingItem.quantity + event.item.quantity,
      );
    } else {
      updatedCart.add(event.item);
    }

    emit(
      state.copyWith(
        cart: state.cart.copyWith(items: updatedCart),
        status: CartStatus.initial,
      ),
    );
  }

  void _onDecreaseQuantityItem(
    DecreaseQuantityItem event,
    Emitter<CartState> emit,
  ) {
    final updatedCart = List<CartItem>.from(state.cart.items ?? []);

    final index = updatedCart.indexWhere(
      (item) => item.product.id == event.itemId,
    );

    if (index != -1) {
      final existingItem = updatedCart[index];

      if (existingItem.quantity > 1) {
        // Decrease quantity
        updatedCart[index] = existingItem.copyWith(
          quantity: existingItem.quantity - 1,
        );
      } else {
        // Remove item if quantity is 1
        updatedCart.removeAt(index);
      }
    }

    emit(
      state.copyWith(
        cart: state.cart.copyWith(items: updatedCart),
        status: CartStatus.initial,
      ),
    );
  }

  void _onRemoveCartItem(RemoveCartItem event, Emitter<CartState> emit) {
    final updatedCart = List<CartItem>.from(state.cart.items ?? [])
      ..removeWhere((item) => item.product.id == event.itemId);
    emit(state.copyWith(cart: state.cart.copyWith(items: updatedCart)));
  }

  void _onClearCart(ClearCart event, Emitter<CartState> emit) {
    final updatedCart = state.cart.copyWith(items: []);
    emit(state.copyWith(cart: updatedCart));
  }

  FutureOr<void> _onAddProductsToCart(
    AddProductsToCart event,
    Emitter<CartState> emit,
  ) {
    final updatedCart = List<CartItem>.from(state.cart.items ?? []);

    for (int i = 0; i < event.products.length; i++) {
      final product = event.products[i];
      final quantity = event.quantities != null && i < event.quantities!.length
          ? event.quantities![i]
          : 1;

      final existingIndex = updatedCart.indexWhere(
        (item) => item.product.id == product.id,
      );

      if (existingIndex != -1) {
        final existingItem = updatedCart[existingIndex];
        updatedCart[existingIndex] = existingItem.copyWith(
          quantity: existingItem.quantity + quantity,
        );
      } else {
        // Add new product to cart
        final newItem = CartItem(product: product, quantity: quantity);
        updatedCart.add(newItem);
      }
    }

    emit(
      state.copyWith(
        cart: state.cart.copyWith(items: updatedCart),
        status: CartStatus.initial,
      ),
    );
  }
}
