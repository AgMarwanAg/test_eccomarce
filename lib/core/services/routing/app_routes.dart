import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_eccomarce/features/home/presentation/cubit/home_navigation_cubit.dart';
import 'package:test_eccomarce/features/home/presentation/home_screen.dart';
import '../../../shared/widgets/app_scaffold.dart';
import '../../../shared/widgets/text_widget.dart';
import '../../logging/logger.dart';
import 'navigator_service.dart';

part 'router_service.dart';

abstract class AppRoutes {
  static List<RouteBase> routes = [
    GoRoute(
      name: HomeScreen.name,
      path: HomeScreen.path,
      builder: (context, state) => BlocProvider(
        create: (context) => HomeNavigationCubit(),
        child: const HomeScreen(),
      ),
    ),

    // GoRoute(path: OnboardingScreen.path, builder: (context, state) => const OnboardingScreen()),
  ];
}
