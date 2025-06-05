part of 'create_lesson_bloc.dart';

abstract class CreateLessonState extends Equatable {}

class CreateLessonInitialState extends CreateLessonState {
  @override
  List<Object?> get props => [];
}

class CreateLessonLoadedState extends CreateLessonState {
  final Lesson? lesson;

  CreateLessonLoadedState({required this.lesson});
  
  @override
  List<Object?> get props => [lesson];
}

class CreateLessonLoadingState extends CreateLessonState {

  CreateLessonLoadingState();

  @override
  List<Object?> get props => [];
}

class CreateLessonErrorState extends CreateLessonState {
  final String? message;

  CreateLessonErrorState(this.message);

  @override
  List<Object?> get props => [message];
}

