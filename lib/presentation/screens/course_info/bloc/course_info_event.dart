part of 'course_info_bloc.dart';

abstract class CourseInfoEvent extends Equatable {}

class CourseInfoLoadEvent extends CourseInfoEvent {
  final int id;

  CourseInfoLoadEvent({required this.id});

  @override
  List<Object?> get props => [id];
}

class CourseInfoDeleteLessonEvent extends CourseInfoEvent {
  final int courseId;
  final int lessonId;

  CourseInfoDeleteLessonEvent({required this.courseId, required this.lessonId});

  @override
  List<Object?> get props => [courseId, lessonId];
}
