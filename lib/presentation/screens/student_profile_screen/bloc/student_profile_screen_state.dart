part of 'student_profile_screen_bloc.dart';

abstract class StudentProfileScreenState extends Equatable {}

class ProfileScreenInitialState extends StudentProfileScreenState {
  @override
  List<Object?> get props => [];
}

class StudentProfileScreenLoadingState extends StudentProfileScreenState {
  @override
  List<Object?> get props => [];
}

class StudentProfileScreenLoadedState extends StudentProfileScreenState {
  final User user;
  final Profile profile;
  final List<CourseAdmission>? admissions;

  StudentProfileScreenLoadedState(
      {required this.user, required this.profile, required this.admissions});

  @override
  List<Object?> get props => [user, profile, admissions];
}

class StudentProfileScreenErrorState extends StudentProfileScreenState {
  final String message;
  
  StudentProfileScreenErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
