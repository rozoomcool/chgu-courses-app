part of 'student_course_info_bloc.dart';

abstract class StudentCourseInfoEvent extends Equatable {}

class StudentCourseInfoLoadEvent extends StudentCourseInfoEvent {
  final int id;

  StudentCourseInfoLoadEvent({required this.id});

  @override
  List<Object?> get props => [id];
}

class StudentCourseInfoAddAdmissionEvent extends StudentCourseInfoEvent {
  final int courseId;

  StudentCourseInfoAddAdmissionEvent({required this.courseId});

  @override
  List<Object?> get props => [courseId];
}

