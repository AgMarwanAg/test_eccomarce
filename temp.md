
class OrderBloc extends Bloc<OrderEvent, OrderState> {
 
  OrderBloc( ) : super(OrderState(order: Order(cart: []))) {
     on<AddCartItem>(_onAddCartItem);
    on<DecreaseQuantityItem>(_onDecreaseQuantityItem);
    on<RemoveCartItem>(_onRemoveCartItem);
    on<ClearCart>(_onClearCart);
    on<AddProductsToCart>(_onAddProductsToCart);
  }

  void _onAddCartItem(AddCartItem event, Emitter<OrderState> emit) {
   
    final updatedCart = List<CartItem>.from(state.order.cart ?? []);
    final index = updatedCart.indexWhere((item) => item.product.id == event.item.product.id);

    
    if (index != -1) {
      final existingItem = updatedCart[index];
      updatedCart[index] = existingItem.copyWith(quantity: existingItem.quantity + event.item.quantity);
    } else {
      updatedCart.add(event.item);
    }

    emit(
      state.copyWith(
        order: state.order.copyWith(cart: updatedCart),
        status: OrderStatus.initial,
      ),
    );
  }

  void _onDecreaseQuantityItem(DecreaseQuantityItem event, Emitter<OrderState> emit) {
    final updatedCart = List<CartItem>.from(state.order.cart ?? []);

    final index = updatedCart.indexWhere((item) => item.product.id == event.itemId);

    if (index != -1) {
      final existingItem = updatedCart[index];

      if (existingItem.quantity > 1) {
        // Decrease quantity
        updatedCart[index] = existingItem.copyWith(quantity: existingItem.quantity - 1);
      } else {
        // Remove item if quantity is 1
        updatedCart.removeAt(index);
      }
    }

    emit(
      state.copyWith(
        order: state.order.copyWith(cart: updatedCart),
        status: OrderStatus.initial,
      ),
    );
  }

  void _onRemoveCartItem(RemoveCartItem event, Emitter<OrderState> emit) {
    final updatedCart = List<CartItem>.from(state.order.cart ?? [])..removeWhere((item) => item.product.id == event.itemId);
    emit(state.copyWith(order: state.order.copyWith(cart: updatedCart)));
  }

  // void _onUpdateCartItem(UpdateCartItem event, Emitter<OrderState> emit) {
  //   final updatedCart = (state.order.cart ?? []).map((item) {
  //     return item.product.id == event.item.product.id ? event.item : item;
  //   }).toList();
  //   emit(state.copyWith(order: state.order.copyWith(cart: updatedCart)));
  // }

  void _onClearCart(ClearCart event, Emitter<OrderState> emit) {
    final updatedOrder = state.order.copyWith(cart: []);
    emit(state.copyWith(order: updatedOrder));
  }
    

  FutureOr<void> _onAddProductsToCart(AddProductsToCart event, Emitter<OrderState> emit) {
    final updatedCart = List<CartItem>.from(state.order.cart ?? []);

    for (int i = 0; i < event.products.length; i++) {
      final product = event.products[i];
      final quantity = event.quantities != null && i < event.quantities!.length ? event.quantities![i] : 1;

      

      final existingIndex = updatedCart.indexWhere((item) => item.product.id == product.id);

      if (existingIndex != -1) {
        final existingItem = updatedCart[existingIndex];
        updatedCart[existingIndex] = existingItem.copyWith(quantity: existingItem.quantity + quantity);
      } else {
        // Add new product to cart
        final newItem = CartItem(product: product, quantity: quantity);
        updatedCart.add(newItem);
      }
    }

    emit(
      state.copyWith(
        order: state.order.copyWith(cart: updatedCart),
        status: OrderStatus.initial,
      ),
    );
  }

  
}


part of 'temp.md';

abstract class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object?> get props => [];
}



class UpdateNotes extends OrderEvent {
  final String notes;
  const UpdateNotes(this.notes);

  @override
  List<Object?> get props => [notes];
}

class AddCartItem extends OrderEvent {
  final CartItem item;
  const AddCartItem(this.item);

  @override
  List<Object?> get props => [item];
}

class DecreaseQuantityItem extends OrderEvent {
  final int itemId;
  const DecreaseQuantityItem(this.itemId);

  @override
  List<Object?> get props => [itemId];
}

class RemoveCartItem extends OrderEvent {
  final int itemId;
  const RemoveCartItem(this.itemId);

  @override
  List<Object?> get props => [itemId];
}

class UpdateCartItem extends OrderEvent {
  final CartItem item;
  const UpdateCartItem(this.item);

  @override
  List<Object?> get props => [item];
}

class ClearCart extends OrderEvent {}
 

class AddProductsToCart extends OrderEvent {
  final List<ProductModel> products;
  final List<int>? quantities;
  const AddProductsToCart(this.products, {this.quantities});
}

part of 'temp.md';

enum OrderStatus {
  initial,
  loading,
  failure,
  success,
}

extension OrderStatusExtension on OrderStatus {
  bool get isLoading => this == OrderStatus.loading;
  bool get isFailure => this == OrderStatus.failure;
}

class OrderState extends Equatable {
  final Order order;
  final OrderStatus status;
     const OrderState({
    required this.order,
     this.status = OrderStatus.initial,
    
  });

  OrderState copyWith({
    Order? order,
      OrderStatus? status,
     }) {
    return OrderState(
        order: order ?? this.order,
         status: status ?? this.status,
   }

  bool isProductInCart(int productId) => order.cart?.any((item) => item.product.id == productId) ?? false;
  num getProductQuantity(int productId) {
    return order.cart?.firstWhereOrNull((item) => item.product.id == productId)?.quantity ?? 0;
  }

  num getProductUnitPrice(int productId) {
    final cartItem = order.cart?.firstWhereOrNull((item) => item.product.id == productId);

    if (cartItem == null) return 0;

    return cartItem.product.getPrice * cartItem.quantity;
  }

  num getCartTotalAmount() {
    return order.cart?.fold<num>(0, (previousValue, element) => previousValue + (element.product.getPrice * element.quantity)) ?? 0;
  }

  int getCartItemCount() {
    return order.cart?.length ?? 0;
  }

  bool get isCartEmpty => getCartTotalAmount() == 0;
  bool get isCartNotEmpty => !isCartEmpty;


  @override
  List<Object?> get props => [order, errorMessage, status];
}


class CartItem extends Equatable {
  final ProductModel product;
  final num quantity;

  const CartItem({
    required this.product,
    required this.quantity,
  });

  CartItem copyWith({
    ProductModel? product,
    num? quantity,
  }) {
    return CartItem(
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': product.id,
      'quantity': quantity,
    };
  }

  @override
  List<Object?> get props => [product, quantity];
}

class Order extends Equatable {
  final List<CartItem>? cart;
  final String? notes;

  const Order({

    this.cart,
    this.notes,
  });
  factory Order.empty() => const Order();
  Map<String, dynamic> toJson() {
    return {
      'cart': cart?.map((item) => item.toJson()).toList(),
      'notes': notes,
    };
  }

  Order copyWith({
    List<CartItem>? cart,
    String? notes,
  }) {
    return Order(
      cart: cart ?? this.cart,
      notes: notes ?? this.notes,
    );
  }

  @override
  List<Object?> get props => [address, deliveryDate, deliveryType, paymentMethod, coupon, cart, notes];
}