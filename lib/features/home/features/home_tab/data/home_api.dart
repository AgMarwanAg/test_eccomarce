import '../../../../../shared/dio_client/dio_client.dart';
import '../../../../../shared/dio_client/result.dart';

class HomeApi {
  final DioClient _client;

  HomeApi(this._client);

  Future<Result> getHome() async {
     return await _client.get(_EndPoints.getHome);
  }
}

class _EndPoints {
  static const String _root = 'home/';
  static const String _v1 = '/v1/$_root';
  static const String getHome = '$_v1/';
}