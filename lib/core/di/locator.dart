import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../shared/cubits/session_cubit/session_cubit.dart';
import '../../shared/dio_client/dio_client.dart';
import '../caching/shared_pref_services.dart';
import '../localization/localization_service.dart';
import '../services/routing/app_routes.dart';

final sl = GetIt.instance;
Future<void> setUpLocator() async {
  //init services
  sl.registerSingleton<SharedPreferencesService>(SharedPreferencesService(await SharedPreferences.getInstance()));

  sl.registerSingleton<LocalizationService>(LocalizationService());
  sl.registerSingleton<RouterService>(RouterService());
  sl.registerSingleton<DioClient>(DioClient());
  sl.registerLazySingleton<SessionCubit>(() => SessionCubit());

  //Auth
}
