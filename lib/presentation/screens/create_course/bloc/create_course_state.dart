part of 'create_course_bloc.dart';

abstract class CreateCourseState extends Equatable {}

class CreateCourseInitialState extends CreateCourseState {
  @override
  List<Object?> get props => [];
}

class CreateCourseLoadingState extends CreateCourseState {
  @override
  List<Object?> get props => [];
}

class CreateCourseCreatedState extends CreateCourseState {
  final Course course;

  CreateCourseCreatedState({required this.course});

  @override
  List<Object?> get props => [course];
}

class CreateCourseUpdatedState extends CreateCourseState {
  final Course course;

  CreateCourseUpdatedState({required this.course});

  @override
  List<Object?> get props => [course];
}

class CreateCourseLoadedState extends CreateCourseState {
  final Course course;

  CreateCourseLoadedState({required this.course});
  
  @override
  List<Object?> get props => [course];
}

class CreateCourseErrorState extends CreateCourseState {
  final String message;
  
  CreateCourseErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
