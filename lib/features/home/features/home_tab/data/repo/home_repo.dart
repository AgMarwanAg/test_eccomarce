import 'package:test_eccomarce/features/home/features/home_tab/data/home_api.dart';
import 'package:test_eccomarce/features/home/features/home_tab/data/model/home_model.dart';
import 'package:test_eccomarce/features/home/features/home_tab/domain/entities/home_entity.dart';
import 'package:test_eccomarce/features/home/features/home_tab/domain/repositories/home_repository.dart';
import 'package:test_eccomarce/shared/dio_client/response_model.dart';
import 'package:test_eccomarce/shared/dio_client/result.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeApi _api;
  HomeRepositoryImpl(this._api);

  @override
  Future<Result<HomeEntity>> getHome() {
    return Result.handleApiResponse(_api.getHome(), (data) {
      final model = HomeModel.fromJson(ResponseModel.fromJson(data).data);
      return model.toEntity();
    });
  }
}
