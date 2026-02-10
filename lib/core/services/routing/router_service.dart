part of 'app_routes.dart';

class RouterService {
  final GoRouter router;
  RouterService()
    : router = GoRouter(
        navigatorKey: NavigationService.navigatorKey,
        initialLocation: setInitialRoute(),
        // initialLocation: ,
        redirect: (context, state) async {
          // NavigationService.updateCurrentContext(context);
          // if (_protectedRoutes.contains(state.uri.toString()) && UserModel.isGuestUser) {
          //   return LoginScreen.path;
          // }
          Logger.route(state.uri.toString());
          return null; // No redirection needed
        },
        routes: AppRoutes.routes,
        errorBuilder: (context, state) => ErrorScreen(state: state),
      );
  // all routes that need authentication must be added to this list
  // if the user is not authenticated, they will be redirected to the login screen
  // No need for extra logic in view
  
  // static const List<String> _protectedRoutes = [

  // ];
  static String setInitialRoute() {
    return HomeScreen.path;
    // return LoginScreen.path;
  }
}

class ErrorScreen extends StatelessWidget {
  final GoRouterState state;
  const ErrorScreen({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Center(child: TextWidget(state.error?.message, style: AppTextStyle.s10W600, maxLines: 2)),
    );
  }
}
