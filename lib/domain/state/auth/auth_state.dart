part of 'auth_cubit.dart';

sealed class AuthState extends Equatable {}

final class UnknownAuthState extends AuthState {
  @override
  List<Object?> get props => [];
}

final class AuthenticatedAuthState extends AuthState {

  final User user;

  AuthenticatedAuthState({required this.user});

  @override
  List<Object?> get props => [user];
}

final class SuccessfluRegisteredAuthState extends AuthState {
  @override
  List<Object?> get props => [];
}

final class UnauthorizedAuthState extends AuthState {
  @override
  List<Object?> get props => [];
}
