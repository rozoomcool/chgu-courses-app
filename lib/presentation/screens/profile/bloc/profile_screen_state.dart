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
  final Profile profile;
  final List<Course>? courses;

  ProfileScreenLoadedState(
      {required this.user, required this.profile, required this.courses});

  @override
  List<Object?> get props => [user, profile, courses];
}

class ProfileScreenErrorState extends ProfileScreenState {
  final String message;
  
  ProfileScreenErrorState(this.message);

  @override
  List<Object?> get props => [];
}
