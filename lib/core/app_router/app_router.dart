import 'package:auto_route/auto_route.dart';
import 'package:userapp/core/app_router/app_router.gr.dart';

part 'route_names.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen|Page,Route')
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => RouteType.material(); //.cupertino, .adaptive ..etc

  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: SplashRoute.page, path: RouteNames.splash, initial: true),
    AutoRoute(page: LoginRoute.page, path: RouteNames.login),
    AutoRoute(page: HomeRoute.page, path: RouteNames.home),
  ];

  @override
  List<AutoRouteGuard> get guards => [
    // optionally add root guards here
  ];
}
