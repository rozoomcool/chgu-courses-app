part of 'course_info_bloc.dart';

abstract class CourseInfoEvent extends Equatable {}

class CourseInfoLoadEvent extends CourseInfoEvent {
  final int id;

  CourseInfoLoadEvent({required this.id});
  
  @override
  List<Object?> get props => [id];
}