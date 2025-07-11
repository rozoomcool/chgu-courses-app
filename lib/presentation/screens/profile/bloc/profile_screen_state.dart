part of 'profile_screen_bloc.dart';

abstract class ProfileScreenState extends Equatable {}

class ProfileScreenInitialState extends ProfileScreenState {
  @override
  List<Object?> get props => [];
}

class ProfileScreenLoadingState extends ProfileScreenState {
  @override
  List<Object?> get props => [];
}

class ProfileScreenLoadedState extends ProfileScreenState {
  final User user;

  ProfileScreenLoadedState(
      {required this.user});

  @override
  List<Object?> get props => [user];
}

class ProfileScreenErrorState extends ProfileScreenState {
  final String message;
  
  ProfileScreenErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
