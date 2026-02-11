import 'package:test_eccomarce/shared/dio_client/api_exception.dart';

import '../../../../../shared/dio_client/dio_client.dart';
import '../../../../../shared/dio_client/result.dart';

class HomeApi {
  final DioClient _client;

  HomeApi(this._client);

  Future<Result> _getProducts() async {
    return await _client.get(_EndPoints.products);
  }

  Future<Result> _getCategories() async {
    return await _client.get(_EndPoints.categories);
  }

  Future<Result> getHome() async {
    final products = await _getProducts();
    final categories = await _getCategories();
    if (products.isSuccess && categories.isSuccess) {
      return Result.success({
        'products': products.data,
        'categories': categories.data,
      });
    }
    //Simulate no internet 
    return Result.failure(
      ApiException(message: 'no Internet', statusCode: 503),
    );
  }
}

class _EndPoints {
  // static const String _root = 'home/';
  static const String products = '/products';
  static const String categories = '/products/categories';
}
