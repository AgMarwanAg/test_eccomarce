import 'package:test_eccomarce/core/logging/logger.dart';
import 'package:test_eccomarce/features/home/features/home_tab/data/datasources/home_local_data_source.dart';
import 'package:test_eccomarce/features/home/features/home_tab/data/home_api.dart';
import 'package:test_eccomarce/features/home/features/home_tab/data/model/home_model.dart';
import 'package:test_eccomarce/features/home/features/home_tab/domain/entities/home_entity.dart';
import 'package:test_eccomarce/features/home/features/home_tab/domain/repositories/home_repository.dart';
import 'package:test_eccomarce/shared/dio_client/response_model.dart';
import 'package:test_eccomarce/shared/dio_client/result.dart';

class HomeRepositoryController implements HomeRepository {
  final HomeApi _api;
  final HomeLocalDataSource _localDataSource;

  HomeRepositoryController({
    required HomeApi api,
    required HomeLocalDataSource localDataSource,
  }) : _api = api,
       _localDataSource = localDataSource;

  @override
  Future<Result<HomeEntity>> getHome() async {
    final cachedData = await _localDataSource.getCachedHome();
    final apiResult = await Result.handleApiResponse(_api.getHome(), (data) {
      return HomeModel.fromJson(ResponseModel.fromJson(data).data);
    });
    return apiResult.fold(
      onSuccess: (homeModel) async {
        await _cacheHomeData(homeModel);
        return Result.success(homeModel.toEntity());
      },
      onFailure: (exception) {
        if (cachedData != null) {
          return Result.success(cachedData.toEntity());
        }
        return Result.failure(exception);
      },
    );
  }

  Future<void> _cacheHomeData(HomeModel homeModel) async {
    try {
      await _localDataSource.cacheHome(homeModel);
    } catch (e) {
      Logger.error(e);
    }
  }
}
