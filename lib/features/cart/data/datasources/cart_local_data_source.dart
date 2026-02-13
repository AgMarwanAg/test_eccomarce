import 'package:test_eccomarce/core/database/database_helper.dart';
import 'package:test_eccomarce/features/cart/data/models/cart_model.dart';

abstract class CartLocalDataSource {
  Future<void> cacheCart(Cart cart);
  Future<Cart?> getCart();
  Future<void> clearCart();
}

class CartLocalDataSourceImpl implements CartLocalDataSource {
  final DatabaseHelper _databaseHelper;

  CartLocalDataSourceImpl(this._databaseHelper);

  @override
  Future<void> cacheCart(Cart cart) async {
    final box = await _databaseHelper.getCartBox();
    await box.put('cart_key', cart);
  }

  @override
  Future<Cart?> getCart() async {
    final box = await _databaseHelper.getCartBox();
    return box.get('cart_key');
  }

  @override
  Future<void> clearCart() async {
    final box = await _databaseHelper.getCartBox();
    await box.clear();
  }
}
