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

class CreateCourseLoadedState extends CreateCourseState {

  @override
  List<Object?> get props => [];
}

class CreateCourseErrorState extends CreateCourseState {
  final String message;
  
  CreateCourseErrorState(this.message);

  @override
  List<Object?> get props => [];
}
