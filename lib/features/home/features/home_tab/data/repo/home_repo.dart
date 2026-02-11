
import 'package:test_eccomarce/features/home/features/home_tab/data/home_api.dart';
import 'package:test_eccomarce/features/home/features/home_tab/data/model/home_model.dart';
import 'package:test_eccomarce/shared/dio_client/response_model.dart';
import 'package:test_eccomarce/shared/dio_client/result.dart';

abstract class HomeRepo {
  Future<Result<HomeModel>> getHome();
}

class HomeRepoImpl implements HomeRepo {
  final HomeApi _api;
  HomeRepoImpl(this._api);

  @override
  Future<Result<HomeModel>> getHome() {
    return Result.handleApiResponse(
      _api.getHome(),
      (data) {
         return HomeModel.fromJson(ResponseModel.fromJson(data).data);
      },
    );
  }
}
