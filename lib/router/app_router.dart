import 'package:auto_route/auto_route.dart';
import 'package:coursera/domain/state/auth/auth_cubit.dart';
import 'package:coursera/presentation/screens/auth/auth_screen.dart';
import 'package:coursera/presentation/screens/auth/register_screen.dart';
import 'package:coursera/presentation/screens/course_info/course_info_screen.dart';
import 'package:coursera/presentation/screens/create_course/create_course_screen.dart';
import 'package:coursera/presentation/screens/create_lesson/create_lesson_screen.dart';
import 'package:coursera/presentation/screens/dashboard/dashboard_screen.dart';
import 'package:coursera/presentation/screens/home/home_screen.dart';
import 'package:coursera/presentation/screens/lesson_info/lesson_info_screen.dart';
import 'package:coursera/presentation/screens/profile/profile_screen.dart';
import 'package:coursera/presentation/screens/root/root_screen.dart';
import 'package:coursera/presentation/screens/service/service_screen.dart';
import 'package:coursera/router/auth_route_guard.dart';
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
        AutoRoute(path: '/course-info', page: CourseInfoRoute.page),
        // AutoRoute(path: '/test', page: CourseInfoRoute.page),
        AutoRoute(path: '/lesson-info', page: LessonInfoRoute.page),
        AutoRoute(path: '/create-course', page: CreateCourseRoute.page),
        AutoRoute(path: '/create-lesson', page: CreateLessonRoute.page),
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
