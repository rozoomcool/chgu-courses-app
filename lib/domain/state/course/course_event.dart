part of 'course_bloc.dart';

abstract class CourseEvent extends Equatable {
  const CourseEvent();

  @override
  List<Object?> get props => [];
}

class LoadCourses extends CourseEvent {}

class AddCourse extends CourseEvent {
  final File file;
  final String title;
  final String description;

  const AddCourse(
      {required this.file, required this.title, required this.description});

  @override
  List<Object?> get props => [file, title, description];
}

class UpdateCourse extends CourseEvent {
  final int id;
  final UpdateCourseRequest course;

  const UpdateCourse(this.course, this.id);

  @override
  List<Object?> get props => [id, course];
}

class DeleteCourse extends CourseEvent {
  final int courseId;

  const DeleteCourse(this.courseId);

  @override
  List<Object?> get props => [courseId];
}
