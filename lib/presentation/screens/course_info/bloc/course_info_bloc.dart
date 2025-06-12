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
    on<CourseInfoDeleteLessonEvent>(_onCourseInfoDeleteLesson);
  }

  void loadCourse(int id) {
    add(CourseInfoLoadEvent(id: id));
  }

  void deleteLesson({required int courseId, required int lessonId}) {
    add(CourseInfoDeleteLessonEvent(courseId: courseId, lessonId: lessonId));
  }

  Future<void> _onCourseInfoLoad(
      CourseInfoLoadEvent event, Emitter<CourseInfoState> emit) async {
    emit(CourseInfoLoadingState());
    try {
      final course = await courseApiRepo.getCourse(event.id,
          teacher: true, lessons: true);

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

  Future<void> _onCourseInfoDeleteLesson(
      CourseInfoDeleteLessonEvent event, Emitter<CourseInfoState> emit) async {
    emit(CourseInfoLoadingState());
    try {
      await courseApiRepo.deleteLesson(
          courseId: event.courseId, lessonId: event.lessonId);
      loadCourse(event.courseId);
    } catch (e) {
      debugPrint(e.toString());
      debugPrint("||| error |||");
      emit(CourseInfoErrorState(e.toString()));
    }
  }
}
