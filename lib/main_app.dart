import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toastification/toastification.dart';
import 'config/themes/themes.dart';
import 'core/di/locator.dart';
import 'core/localization/localization_service.dart';
import 'core/services/routing/app_routes.dart';
import 'providers.dart';
import 'shared/cubits/session_cubit/session_cubit.dart';

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  void initState() {
    super.initState();
  }

   @override
  Widget build(BuildContext context) {
 
    final localizationService = sl<LocalizationService>();
    return ToastificationWrapper(
      child: EasyLocalization(
        supportedLocales: localizationService.supportedLocales,
        path: localizationService.translationPath,
        startLocale: localizationService.currentLocale,
        fallbackLocale: localizationService.fallbackLocale,
        saveLocale: true,
        child: Providers(
          child: ScreenUtilInit(
            designSize: const Size(390, 925),//Size in Figma
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (context, child) {
              return BlocConsumer<SessionCubit, SessionState>(
                listener: (context, state) {
                  // if (state is UnAuthenticated) {
                  //   NavigationService.goTo(LoginScreen.path).then((_) {
                  //     AppToast.showErrorToast(message: 'exc.session_expired');
                  //   });
                  // }
                },
                builder: (context, state) {
                  return MaterialApp.router(
                    theme: AppTheme.lightTheme,
                    debugShowCheckedModeBanner: false,
                    debugShowMaterialGrid: false,
                    routerConfig: sl<RouterService>().router,
                    supportedLocales: context.supportedLocales,
                    localizationsDelegates: context.localizationDelegates,
                    locale: context.locale,
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
