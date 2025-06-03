import 'package:auto_route/auto_route.dart';
import 'package:coursera/domain/state/auth/auth_cubit.dart';
import 'package:coursera/router/app_router.dart';

class AuthGuard extends AutoRouteGuard {
  final AuthState authState;

  AuthGuard(this.authState);

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    if (authState is AuthenticatedAuthState) {
      resolver.next();
    } else {
      resolver.redirect(const AuthRoute());
    }
  }
}
