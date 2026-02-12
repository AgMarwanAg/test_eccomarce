part of 'cart_bloc.dart';

enum CartStatus { initial, loading, failure, success }

extension CartStatusExtension on CartStatus {
  bool get isLoading => this == CartStatus.loading;
  bool get isFailure => this == CartStatus.failure;
}

class CartState extends Equatable {
  final Cart cart;
  final CartStatus status;

  const CartState({required this.cart, this.status = CartStatus.initial});

  CartState copyWith({Cart? cart, CartStatus? status}) {
    return CartState(cart: cart ?? this.cart, status: status ?? this.status);
  }

  bool isProductInCart(int productId) =>
      cart.items?.any((item) => item.product.id == productId) ?? false;

  num getProductQuantity(int productId) {
    try {
      return cart.items
              ?.firstWhere((item) => item.product.id == productId)
              .quantity ??
          0;
    } catch (e) {
      return 0;
    }
  }

  num getProductUnitPrice(int productId) {
    try {
      final cartItem = cart.items?.firstWhere(
        (item) => item.product.id == productId,
      );
      if (cartItem == null) return 0;
      return cartItem.product.price *
          cartItem.quantity; // Assuming price is correct getter
    } catch (e) {
      return 0;
    }
  }

  num getCartTotalAmount() {
    return cart.items?.fold<num>(
          0,
          (previousValue, element) =>
              previousValue + (element.product.price * element.quantity),
        ) ??
        0;
  }

  int getCartItemCount() {
    return cart.items?.length ?? 0;
  }

  bool get isCartEmpty => getCartTotalAmount() == 0;
  bool get isCartNotEmpty => !isCartEmpty;

  @override
  List<Object?> get props => [cart, status];
}
