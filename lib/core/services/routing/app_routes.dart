import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_eccomarce/core/di/locator.dart';
import 'package:test_eccomarce/features/cart/presentation/cart_screen.dart';
import 'package:test_eccomarce/features/home/features/home_tab/presentation/cubit/get_home_cubit.dart';
import 'package:test_eccomarce/features/home/presentation/cubit/home_navigation_cubit.dart';
import 'package:test_eccomarce/features/home/presentation/home_screen.dart';
import 'package:test_eccomarce/features/product_details/presentation/cubit/get_product_details_cubit.dart';
import 'package:test_eccomarce/features/product_details/presentation/product_details_screen.dart';
import 'package:test_eccomarce/features/search/presentation/cubit/search_cubit.dart';
import 'package:test_eccomarce/features/search/presentation/search_screen.dart';
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
      builder: (context, state) => BlocProvider(
        create: (context) => sl<GetProductDetailsCubit>(),
        child: ProductDetailsScreen(id: state.extra as int),
      ),
    ),
    GoRoute(
      path: SearchScreen.path,
      builder: (context, state) => BlocProvider(
        create: (context) => sl<SearchCubit>(),
        child: SearchScreen(),
      ),
    ),

     GoRoute(
      path: CartScreen.path,
      builder: (context, state) => CartScreen(
        isFullScreen: state.extra as bool,
      ),
    ),
  ];
}
