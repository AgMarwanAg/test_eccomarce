part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object?> get props => [];
}

class AddCartItem extends CartEvent {
  final CartItem item;
  const AddCartItem(this.item);

  @override
  List<Object?> get props => [item];
}

class DecreaseQuantityItem extends CartEvent {
  final int itemId;
  const DecreaseQuantityItem(this.itemId);

  @override
  List<Object?> get props => [itemId];
}

class RemoveCartItem extends CartEvent {
  final int itemId;
  const RemoveCartItem(this.itemId);

  @override
  List<Object?> get props => [itemId];
}

class UpdateCartItem extends CartEvent {
  final CartItem item;
  const UpdateCartItem(this.item);

  @override
  List<Object?> get props => [item];
}

class ClearCart extends CartEvent {}

class AddProductsToCart extends CartEvent {
  final List<ProductModel> products;
  final List<int>? quantities;
  const AddProductsToCart(this.products, {this.quantities});

  @override
  List<Object?> get props => [products, quantities];
}

class UpdateNotes extends CartEvent {
  final String notes;
  const UpdateNotes(this.notes);

  @override
  List<Object?> get props => [notes];
}
