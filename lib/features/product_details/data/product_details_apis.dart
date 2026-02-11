import 'package:test_eccomarce/shared/dio_client/api_exception.dart';

import '../../../../../shared/dio_client/dio_client.dart';
import '../../../../../shared/dio_client/result.dart';

class ProductDetailsApis {
  final DioClient _client;

  ProductDetailsApis(this._client);

  Future<Result> getProduct(int id) async {
    return await _client.get(_EndPoints.products(id));
  }
}

class _EndPoints {
  static String products(int id) => '/products/$id';
}
