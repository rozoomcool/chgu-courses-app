// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

/// generated route for
/// [AuthScreen]
class AuthRoute extends PageRouteInfo<void> {
  const AuthRoute({List<PageRouteInfo>? children})
      : super(AuthRoute.name, initialChildren: children);

  static const String name = 'AuthRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const AuthScreen();
    },
  );
}

/// generated route for
/// [CourseInfoScreen]
class CourseInfoRoute extends PageRouteInfo<CourseInfoRouteArgs> {
  CourseInfoRoute({Key? key, required int id, List<PageRouteInfo>? children})
      : super(
          CourseInfoRoute.name,
          args: CourseInfoRouteArgs(key: key, id: id),
          initialChildren: children,
        );

  static const String name = 'CourseInfoRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CourseInfoRouteArgs>();
      return CourseInfoScreen(key: args.key, id: args.id);
    },
  );
}

class CourseInfoRouteArgs {
  const CourseInfoRouteArgs({this.key, required this.id});

  final Key? key;

  final int id;

  @override
  String toString() {
    return 'CourseInfoRouteArgs{key: $key, id: $id}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! CourseInfoRouteArgs) return false;
    return key == other.key && id == other.id;
  }

  @override
  int get hashCode => key.hashCode ^ id.hashCode;
}

/// generated route for
/// [CreateCourseScreen]
class CreateCourseRoute extends PageRouteInfo<CreateCourseRouteArgs> {
  CreateCourseRoute({Key? key, int? id, List<PageRouteInfo>? children})
      : super(
          CreateCourseRoute.name,
          args: CreateCourseRouteArgs(key: key, id: id),
          initialChildren: children,
        );

  static const String name = 'CreateCourseRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CreateCourseRouteArgs>(
        orElse: () => const CreateCourseRouteArgs(),
      );
      return CreateCourseScreen(key: args.key, id: args.id);
    },
  );
}

class CreateCourseRouteArgs {
  const CreateCourseRouteArgs({this.key, this.id});

  final Key? key;

  final int? id;

  @override
  String toString() {
    return 'CreateCourseRouteArgs{key: $key, id: $id}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! CreateCourseRouteArgs) return false;
    return key == other.key && id == other.id;
  }

  @override
  int get hashCode => key.hashCode ^ id.hashCode;
}

/// generated route for
/// [CreateLessonScreen]
class CreateLessonRoute extends PageRouteInfo<void> {
  const CreateLessonRoute({List<PageRouteInfo>? children})
      : super(CreateLessonRoute.name, initialChildren: children);

  static const String name = 'CreateLessonRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const CreateLessonScreen();
    },
  );
}

/// generated route for
/// [DashboardScreen]
class DashboardRoute extends PageRouteInfo<void> {
  const DashboardRoute({List<PageRouteInfo>? children})
      : super(DashboardRoute.name, initialChildren: children);

  static const String name = 'DashboardRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const DashboardScreen();
    },
  );
}

/// generated route for
/// [HomeScreen]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
      : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const HomeScreen();
    },
  );
}

/// generated route for
/// [ProfileScreen]
class ProfileRoute extends PageRouteInfo<void> {
  const ProfileRoute({List<PageRouteInfo>? children})
      : super(ProfileRoute.name, initialChildren: children);

  static const String name = 'ProfileRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ProfileScreen();
    },
  );
}

/// generated route for
/// [RegisterScreen]
class RegisterRoute extends PageRouteInfo<void> {
  const RegisterRoute({List<PageRouteInfo>? children})
      : super(RegisterRoute.name, initialChildren: children);

  static const String name = 'RegisterRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const RegisterScreen();
    },
  );
}

/// generated route for
/// [RootScreen]
class RootRoute extends PageRouteInfo<void> {
  const RootRoute({List<PageRouteInfo>? children})
      : super(RootRoute.name, initialChildren: children);

  static const String name = 'RootRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const RootScreen();
    },
  );
}

/// generated route for
/// [ServiceScreen]
class ServiceRoute extends PageRouteInfo<void> {
  const ServiceRoute({List<PageRouteInfo>? children})
      : super(ServiceRoute.name, initialChildren: children);

  static const String name = 'ServiceRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ServiceScreen();
    },
  );
}
