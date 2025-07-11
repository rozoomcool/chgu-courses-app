import 'package:auto_route/auto_route.dart';
import 'package:eventrecs/domain/state/auth/auth_cubit.dart';
import 'package:eventrecs/presentation/screens/activity/activity_details_screen.dart';
import 'package:eventrecs/presentation/screens/auth/auth_screen.dart';
import 'package:eventrecs/presentation/screens/auth/register_screen.dart';
import 'package:eventrecs/presentation/screens/dashboard/dashboard_screen.dart';
import 'package:eventrecs/presentation/screens/home/home_screen.dart';
import 'package:eventrecs/presentation/screens/profile/profile_screen.dart';
import 'package:eventrecs/presentation/screens/root/root_screen.dart';
import 'package:eventrecs/presentation/screens/service/service_screen.dart';
import 'package:eventrecs/router/auth_route_guard.dart';
import 'package:flutter/material.dart';

// import '../domain/state/auth/auth_cubit.dart';
// import '../presentation/screens/auth/auth_screen.dart';
// import '../presentation/screens/home/home_screen.dart';
// import '../presentation/screens/profile/profile_screen.dart';
// import '../presentation/screens/root/root_screen.dart';
// import '../presentation/screens/service/service_screen.dart';
// import 'auth_route_guard.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends RootStackRouter {
  final AuthState authState;

  AppRouter(this.authState);

  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          path: '/',
          page: RootRoute.page,
          guards: [AuthGuard(authState)],
          children: [
            RedirectRoute(path: '', redirectTo: 'home'),
            AutoRoute(path: 'home', page: HomeRoute.page),
            AutoRoute(path: 'profile', page: ProfileRoute.page),
            AutoRoute(path: 'service', page: ServiceRoute.page),
            AutoRoute(path: 'dashboard', page: DashboardRoute.page),
          ],
        ),
        CustomRoute(
            page: ActivityDetailsRoute.page,
            path: "/activity-details",
            transitionsBuilder: TransitionsBuilders.slideBottom,
            duration: Duration(milliseconds: 150)),
        CustomRoute(
          path: '/auth',
          page: AuthRoute.page,
          transitionsBuilder: TransitionsBuilders.noTransition,
        ),
        CustomRoute(
            path: '/register',
            page: RegisterRoute.page,
            transitionsBuilder: TransitionsBuilders.noTransition),
      ];
}
