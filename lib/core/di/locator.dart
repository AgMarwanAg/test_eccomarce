import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_eccomarce/core/database/database_helper.dart';
import 'package:test_eccomarce/features/home/features/home_tab/data/datasources/home_local_data_source.dart';
import 'package:test_eccomarce/features/home/features/home_tab/data/home_api.dart';
import 'package:test_eccomarce/features/home/features/home_tab/data/repo/home_api_repository_impl.dart';
import 'package:test_eccomarce/features/home/features/home_tab/data/repo/home_local_repository_impl.dart';
import 'package:test_eccomarce/features/home/features/home_tab/data/repo/home_repository_controller.dart';
import 'package:test_eccomarce/features/home/features/home_tab/domain/repositories/home_repository.dart';
import 'package:test_eccomarce/features/home/features/home_tab/domain/usecases/get_home_usecase.dart';
import 'package:test_eccomarce/features/home/features/home_tab/presentation/cubit/get_home_cubit.dart';
import 'package:test_eccomarce/features/product_details/data/product_details_apis.dart';
import 'package:test_eccomarce/features/product_details/data/repo/product_details_repo.dart';
import 'package:test_eccomarce/features/product_details/presentation/cubit/get_product_details_cubit.dart';
import '../../shared/cubits/session_cubit/session_cubit.dart';
import '../../shared/dio_client/dio_client.dart';
import '../caching/shared_pref_services.dart';
import '../localization/localization_service.dart';
import '../services/routing/app_routes.dart';

final sl = GetIt.instance;
Future<void> setUpLocator() async {
  //init services
  sl.registerSingleton<SharedPreferencesService>(
    SharedPreferencesService(await SharedPreferences.getInstance()),
  );

  sl.registerSingleton<LocalizationService>(LocalizationService());
  sl.registerSingleton<RouterService>(RouterService());
  sl.registerSingleton<DioClient>(DioClient());
  sl.registerLazySingleton<SessionCubit>(() => SessionCubit());

  //home

  sl.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper.instance);
  sl.registerLazySingleton<HomeApi>(() => HomeApi(sl<DioClient>()));
  sl.registerLazySingleton<HomeLocalDataSource>(
    () => HomeLocalDataSourceImpl(sl<DatabaseHelper>()),
  );

  sl.registerLazySingleton<HomeRepository>(
    () => HomeApiRepositoryImpl(sl<HomeApi>()),
    instanceName: 'apiRepo',
  );

  sl.registerLazySingleton<HomeLocalRepositoryImpl>(
    () => HomeLocalRepositoryImpl(sl<HomeLocalDataSource>()),
  );

  sl.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryController(
      api: sl<HomeApi>(),
      localDataSource: sl<HomeLocalDataSource>(),
    ),
  );

  sl.registerLazySingleton<GetHomeUseCase>(
    () => GetHomeUseCase(sl<HomeRepository>()),
  );
  sl.registerFactory<GetHomeCubit>(() => GetHomeCubit(sl<GetHomeUseCase>()));

  sl.registerLazySingleton<ProductDetailsApis>(
    () => ProductDetailsApis(sl<DioClient>()),
  );
  sl.registerLazySingleton<ProductDetailsRepo>(
    () => ProductDetailsRepoImpl(sl<ProductDetailsApis>()),
  );
  sl.registerFactory<GetProductDetailsCubit>(
    () => GetProductDetailsCubit(sl<ProductDetailsRepo>()),
  );
}
