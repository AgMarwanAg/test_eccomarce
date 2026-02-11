import 'package:test_eccomarce/features/home/features/home_tab/data/home_api.dart';
import 'package:test_eccomarce/features/home/features/home_tab/data/model/home_model.dart';
import 'package:test_eccomarce/features/home/features/home_tab/domain/entities/home_entity.dart';
import 'package:test_eccomarce/features/home/features/home_tab/domain/repositories/home_repository.dart';
import 'package:test_eccomarce/shared/dio_client/response_model.dart';
import 'package:test_eccomarce/shared/dio_client/result.dart';

/// API repository implementation - handles only remote data operations
class HomeApiRepositoryImpl implements HomeRepository {
  final HomeApi _api;

  HomeApiRepositoryImpl(this._api);

  @override
  Future<Result<HomeEntity>> getHome() async {
    return Result.handleApiResponse(_api.getHome(), (data) {
      final model = HomeModel.fromJson(ResponseModel.fromJson(data).data);
      return model.toEntity();
    });
  }
}
