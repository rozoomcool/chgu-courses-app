import 'package:coursera/domain/api/course/course_api_client.dart';
import 'package:coursera/domain/model/course/course.dart';
import 'package:coursera/repository/shared/auth_shared_repository.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'course_info_event.dart';
part 'course_info_state.dart';

class CourseInfoBloc extends Bloc<CourseInfoEvent, CourseInfoState> {
  final CourseApiClient courseApiRepo;
  final AuthSharedRepository authSharedRepository;

  CourseInfoBloc(this.courseApiRepo, this.authSharedRepository)
      : super(CourseInfoInitialState()) {
    on<CourseInfoLoadEvent>(_onCourseInfoLoad);
  }

  void loadCourse(int id) {
    add(CourseInfoLoadEvent(id: id));
  }

  Future<void> _onCourseInfoLoad(
      CourseInfoLoadEvent event, Emitter<CourseInfoState> emit) async {
    emit(CourseInfoLoadingState());
    try {
      final course = await courseApiRepo.getCourse(event.id,
          teacher: true, students: false, lessons: true);

      if (course.teacherId == authSharedRepository.getId()) {
        emit(CourseInfoLoadedState(course: course, isOwner: true));
      } else {
        emit(CourseInfoLoadedState(course: course, isOwner: false));
      }
    } catch (e) {
      debugPrint(e.toString());
      debugPrint("||| error |||");
      emit(CourseInfoErrorState(e.toString()));
    }
  }
}
