import 'package:coursera/domain/api/lesson/lesson_api_client.dart';
import 'package:coursera/domain/model/course/course.dart';
import 'package:coursera/domain/model/lesson/lesson.dart';
import 'package:coursera/repository/shared/auth_shared_repository.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'lesson_info_event.dart';
part 'lesson_info_state.dart';

class LessonInfoBloc extends Bloc<LessonInfoEvent, LessonInfoState> {
  final LessonApiClient lessonApiRepo;
  final AuthSharedRepository authSharedRepository;

  LessonInfoBloc(this.lessonApiRepo, this.authSharedRepository)
      : super(LessonInfoInitialState()) {
    on<LessonInfoLoadEvent>(_onCourseInfoLoad);
  }

  void loadLesson(int id) {
    add(LessonInfoLoadEvent(id: id));
  }

  Future<void> _onCourseInfoLoad(
      LessonInfoLoadEvent event, Emitter<LessonInfoState> emit) async {
    emit(LessonInfoLoadingState());
    try {
      final lesson = await lessonApiRepo.getOne(event.id);

      // if (course.teacherId == authSharedRepository.getId()) {
        emit(LessonInfoLoadedState(lesson: lesson, isOwner: true));
      // } else {
      //   emit(LessonInfoLoadedState(course: course, isOwner: false));
      // }
    } catch (e) {
      debugPrint(e.toString());
      debugPrint("||| error |||");
      emit(LessonInfoErrorState(e.toString()));
    }
  }
}
