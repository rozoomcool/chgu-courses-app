part of 'create_course_bloc.dart';

abstract class CreateCourseEvent extends Equatable {}

class CreateCourseCreateEvent extends CreateCourseEvent {
  final File file;
  final String title;
  final String description;

  CreateCourseCreateEvent(
      {required this.file, required this.title, required this.description});

  @override
  List<Object?> get props => [file, title, description];
}
