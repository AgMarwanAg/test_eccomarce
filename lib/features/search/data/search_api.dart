import 'package:test_eccomarce/shared/dio_client/dio_client.dart';
import 'package:test_eccomarce/shared/dio_client/result.dart';

class SearchApi {
final DioClient _client;

  SearchApi(this._client);

  Future<Result> search(String?q,int? skip,) async {
    return await _client.get(_EndPoints.search,queryParameters: {
      'q':q,
      'skip':skip,
      'limit':15
    }..removeWhere((key, value) => value==null,));
  }
}


abstract class _EndPoints{
  static const String search='/products/search';
}