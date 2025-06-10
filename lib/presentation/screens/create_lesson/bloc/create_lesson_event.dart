part of 'create_lesson_bloc.dart';

abstract class CreateLessonEvent extends Equatable {}

class CreateLessonSaveChangeEvent extends CreateLessonEvent {
  final int? id;
  final int courseId;
  final String title;
  final String lecture;

  CreateLessonSaveChangeEvent(
      {required this.courseId, required this.id, required this.title, required this.lecture});

  @override
  List<Object?> get props => [id, title, lecture];
}

class CreateLessonLoadEvent extends CreateLessonEvent {
  final int? id;
  final int courseId;

  CreateLessonLoadEvent(
      {required this.id, required this.courseId});

  @override
  List<Object?> get props => [id];
}
