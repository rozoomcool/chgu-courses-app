import 'package:coursera/domain/api/course/course_api_client.dart';
import 'package:coursera/domain/model/course/course.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'course_info_event.dart';
part 'course_info_state.dart';

class CourseInfoBloc extends Bloc<CourseInfoEvent, CourseInfoState> {
  final CourseApiClient courseApiRepo;

  CourseInfoBloc(this.courseApiRepo) : super(CourseInfoInitialState()) {
    on<CourseInfoLoadEvent>(_onCourseInfoLoad);
  }

  void loadCourse(int id) {
    add(CourseInfoLoadEvent(id: id));
  }

  Future<void> _onCourseInfoLoad(
      CourseInfoLoadEvent event, Emitter<CourseInfoState> emit) async {
    emit(CourseInfoLoadingState());
    try {
      final course = await courseApiRepo.getCourse(event.id);

      emit(CourseInfoLoadedState(course: course));
    } catch (e) {
      debugPrint(e.toString());
      debugPrint("||| error |||");
      emit(CourseInfoErrorState(e.toString()));
    }
  }
}
