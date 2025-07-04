part of 'course_info_bloc.dart';

abstract class CourseInfoState extends Equatable {}

class CourseInfoInitialState extends CourseInfoState {

  @override
  List<Object?> get props => [];
}

class CourseInfoLoadingState extends CourseInfoState {
  @override
  List<Object?> get props => [];
}

class CourseInfoLoadedState extends CourseInfoState {
  final bool isOwner;
  final Course course;

  CourseInfoLoadedState({required this.course, required this.isOwner});

  @override
  List<Object?> get props => [];
}

class CourseInfoErrorState extends CourseInfoState {
  final String message;
  
  CourseInfoErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
