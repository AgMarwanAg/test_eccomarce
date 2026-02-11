import 'package:test_eccomarce/features/home/features/home_tab/domain/entities/home_entity.dart';
import 'package:test_eccomarce/features/home/features/home_tab/domain/repositories/home_repository.dart';
import 'package:test_eccomarce/shared/dio_client/result.dart';

class GetHomeUseCase {
  final HomeRepository _repository;

  GetHomeUseCase(this._repository);

  Future<Result<HomeEntity>> call() {
    return _repository.getHome();
  }
}
