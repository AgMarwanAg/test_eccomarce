import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_eccomarce/core/di/locator.dart';
import 'package:test_eccomarce/features/home/features/home_tab/presentation/cubit/get_home_cubit.dart';
import 'package:test_eccomarce/features/home/presentation/cubit/home_navigation_cubit.dart';
import 'package:test_eccomarce/features/home/presentation/home_screen.dart';
import 'package:test_eccomarce/features/product_details/presentation/product_details_screen.dart';
import '../../../shared/widgets/app_scaffold.dart';
import '../../../shared/widgets/text_widget.dart';
import '../../logging/logger.dart';
import 'navigator_service.dart';

part 'router_service.dart';

abstract class AppRoutes {
  static List<RouteBase> routes = [
    GoRoute(
      path: HomeScreen.path,
      builder: (context, state) => MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => HomeNavigationCubit()),
          BlocProvider(create: (context) => sl<GetHomeCubit>()),
        ],
        child: HomeScreen(),
      ),
    ),
    GoRoute(
      path: ProductDetailsScreen.path,
      builder: (context, state) =>
          ProductDetailsScreen(id: state.extra as int),
    ),
  ];
}
