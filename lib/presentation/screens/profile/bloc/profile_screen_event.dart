part of 'profile_screen_bloc.dart';

abstract class ProfileScreenEvent extends Equatable {}

class ProfileScreenLoadEvent extends ProfileScreenEvent {
  @override
  List<Object?> get props => [];
}

class ProfileScreenDeleteEvent extends ProfileScreenEvent {
  final int id;
  final Function onDeleteSuccessful;

  ProfileScreenDeleteEvent({
    required this.id,
    required this.onDeleteSuccessful,
  });

  @override
  List<Object?> get props => [id];
}
