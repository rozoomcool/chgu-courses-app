part of 'student_course_info_bloc.dart';

abstract class StudentCourseInfoState extends Equatable {}

class StudentCourseInfoInitialState extends StudentCourseInfoState {

  @override
  List<Object?> get props => [];
}

class StudentCourseInfoLoadingState extends StudentCourseInfoState {
  @override
  List<Object?> get props => [];
}

class StudentCourseInfoLoadedState extends StudentCourseInfoState {
  final Course course;
  final CourseAdmission? admission;

  StudentCourseInfoLoadedState({required this.course, this.admission});

  @override
  List<Object?> get props => [course, admission];
}

class StudentCourseInfoErrorState extends StudentCourseInfoState {
  final String message;
  
  StudentCourseInfoErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
