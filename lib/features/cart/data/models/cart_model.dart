import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:test_eccomarce/shared/models/product_model.dart';

part 'cart_model.g.dart';

@HiveType(typeId: 3)
class CartItem extends Equatable {
  @HiveField(0)
  final ProductModel product;
  @HiveField(1)
  final num quantity;

  const CartItem({required this.product, required this.quantity});

  CartItem copyWith({ProductModel? product, num? quantity}) {
    return CartItem(
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': product.id, 'quantity': quantity};
  }

  @override
  List<Object?> get props => [product, quantity];
}

@HiveType(typeId: 4)
class Cart extends Equatable {
  @HiveField(0)
  final List<CartItem>? items;
  @HiveField(1)
  final String? notes;

  const Cart({this.items, this.notes});

  factory Cart.empty() => const Cart();

  Map<String, dynamic> toJson() {
    return {
      'cart': items?.map((item) => item.toJson()).toList(),
      'notes': notes,
    };
  }

  Cart copyWith({List<CartItem>? items, String? notes}) {
    return Cart(items: items ?? this.items, notes: notes ?? this.notes);
  }

  @override
  List<Object?> get props => [items, notes];
}
