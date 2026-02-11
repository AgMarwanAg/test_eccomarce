import 'package:test_eccomarce/features/home/features/home_tab/data/datasources/home_local_data_source.dart';
import 'package:test_eccomarce/features/home/features/home_tab/data/model/home_model.dart';
import 'package:test_eccomarce/features/home/features/home_tab/domain/entities/home_entity.dart';
import 'package:test_eccomarce/features/home/features/home_tab/domain/repositories/home_repository.dart';
import 'package:test_eccomarce/shared/dio_client/api_exception.dart';
import 'package:test_eccomarce/shared/dio_client/result.dart';

/// Local repository implementation - handles only cache operations
class HomeLocalRepositoryImpl implements HomeRepository {
  final HomeLocalDataSource _localDataSource;

  HomeLocalRepositoryImpl(this._localDataSource);

  @override
  Future<Result<HomeEntity>> getHome() async {
    try {
      final cachedData = await _localDataSource.getCachedHome();

      if (cachedData != null) {
        return Result.success(cachedData.toEntity());
      }

      // No cached data available
      return Result.failure(
        ApiException(message: 'No cached data available', statusCode: 404),
      );
    } catch (e) {
      return Result.failure(
        ApiException(
          message: 'Failed to retrieve cached data: $e',
          statusCode: 500,
        ),
      );
    }
  }

  /// Cache home data (additional method for controller to use)
  Future<void> cacheHome(HomeModel homeModel) async {
    await _localDataSource.cacheHome(homeModel);
  }
}
