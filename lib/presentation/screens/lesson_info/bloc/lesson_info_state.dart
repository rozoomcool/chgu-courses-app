part of 'lesson_info_bloc.dart';

abstract class LessonInfoState extends Equatable {}

class LessonInfoInitialState extends LessonInfoState {

  @override
  List<Object?> get props => [];
}

class LessonInfoLoadingState extends LessonInfoState {
  @override
  List<Object?> get props => [];
}

class LessonInfoLoadedState extends LessonInfoState {
  final bool isOwner;
  final Lesson lesson;

  LessonInfoLoadedState({required this.lesson, required this.isOwner});

  @override
  List<Object?> get props => [];
}

class LessonInfoErrorState extends LessonInfoState {
  final String message;
  
  LessonInfoErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
