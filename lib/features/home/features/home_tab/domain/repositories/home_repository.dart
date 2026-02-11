import 'package:test_eccomarce/features/home/features/home_tab/domain/entities/home_entity.dart';
import 'package:test_eccomarce/shared/dio_client/result.dart';

abstract class HomeRepository {
  Future<Result<HomeEntity>> getHome();
}
