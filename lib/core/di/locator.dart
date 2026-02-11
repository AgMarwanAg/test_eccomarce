import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_eccomarce/features/home/features/home_tab/data/home_api.dart';
import 'package:test_eccomarce/features/home/features/home_tab/data/repo/home_repo.dart';
import 'package:test_eccomarce/features/home/features/home_tab/presentation/cubit/get_home_cubit.dart';
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

  sl.registerLazySingleton<HomeApi>(() => HomeApi(sl<DioClient>()));
  sl.registerLazySingleton<HomeRepo>(() => HomeRepoImpl(sl<HomeApi>()));
  sl.registerFactory<GetHomeCubit>(() => GetHomeCubit(sl<HomeRepo>()));
}
