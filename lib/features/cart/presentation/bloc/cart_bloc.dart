import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:test_eccomarce/core/services/routing/navigator_service.dart';
import 'package:test_eccomarce/features/cart/data/datasources/cart_local_data_source.dart';
import 'package:test_eccomarce/features/cart/data/models/cart_model.dart';
import 'dart:developer';

import 'package:test_eccomarce/shared/dio_client/result.dart';
import 'package:test_eccomarce/shared/widgets/success_overlay.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartLocalDataSource _cartLocalDataSource;

  CartBloc(this._cartLocalDataSource)
    : super(const CartState(cart: Cart(items: []))) {
    on<LoadCart>(_onLoadCart);
    on<AddCartItem>(_onAddCartItem);
    on<DecreaseQuantityItem>(_onDecreaseQuantityItem);
    on<RemoveCartItem>(_onRemoveCartItem);
    on<ClearCart>(_onClearCart);
  }

  Future<void> _onLoadCart(LoadCart event, Emitter<CartState> emit) async {
    try {
      final cart = await _cartLocalDataSource.getCart();
      if (cart != null) {
        emit(state.copyWith(cart: cart));
      }
    } catch (e) {
      log('Error loading cart: $e');
    }
  }

  void _onAddCartItem(AddCartItem event, Emitter<CartState> emit) async {
    final updatedCart = List<CartItem>.from(state.cart.items ?? []);
    final index = updatedCart.indexWhere(
      (item) => item.product.id == event.item.product.id,
    );

    if (index != -1) {
      final existingItem = updatedCart[index];
      updatedCart[index] = existingItem.copyWith(
        quantity: existingItem.quantity + 1,
      );
    } else {
      updatedCart.add(event.item);
    }

    final newCart = state.cart.copyWith(items: updatedCart);
    emit(state.copyWith(cart: newCart, status: CartStatus.initial));
    await _cartLocalDataSource.cacheCart(newCart);
  }

  void _onDecreaseQuantityItem(
    DecreaseQuantityItem event,
    Emitter<CartState> emit,
  ) async {
    final updatedCart = List<CartItem>.from(state.cart.items ?? []);

    final index = updatedCart.indexWhere(
      (item) => item.product.id == event.itemId,
    );

    if (index != -1) {
      final existingItem = updatedCart[index];

      if (existingItem.quantity > 1) {
        updatedCart[index] = existingItem.copyWith(
          quantity: existingItem.quantity - 1,
        );
      } else {
        updatedCart.removeAt(index);
      }
    }

    final newCart = state.cart.copyWith(items: updatedCart);
    emit(state.copyWith(cart: newCart, status: CartStatus.initial));
    await _cartLocalDataSource.cacheCart(newCart);
  }

  void _onRemoveCartItem(RemoveCartItem event, Emitter<CartState> emit) async {
    final updatedCart = List<CartItem>.from(state.cart.items ?? [])
      ..removeWhere((item) => item.product.id == event.itemId);

    final newCart = state.cart.copyWith(items: updatedCart);
    emit(state.copyWith(cart: newCart));
    await _cartLocalDataSource.cacheCart(newCart);
  }

  void _onClearCart(ClearCart event, Emitter<CartState> emit) async {
    final updatedCart = state.cart.copyWith(items: []);
    emit(state.copyWith(cart: updatedCart));
    await _cartLocalDataSource.clearCart();
  }
}
