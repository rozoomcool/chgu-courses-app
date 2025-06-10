part of 'lesson_info_bloc.dart';

abstract class LessonInfoEvent extends Equatable {}

class LessonInfoLoadEvent extends LessonInfoEvent {
  final int id;

  LessonInfoLoadEvent({required this.id});
  
  @override
  List<Object?> get props => [id];
}