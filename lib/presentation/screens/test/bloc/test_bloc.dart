// import 'package:coursera/domain/api/lesson/lesson_api_client.dart';
// import 'package:coursera/domain/model/lesson/lesson.dart';
// import 'package:coursera/domain/model/test/test.dart';
// import 'package:coursera/repository/shared/auth_shared_repository.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:equatable/equatable.dart';

// part 'test_event.dart';
// part 'test_state.dart';

// class LessonInfoBloc extends Bloc<LessonInfoEvent, TestScreenState> {
//   final LessonApiClient lessonApiRepo;
//   final AuthSharedRepository authSharedRepository;

//   LessonInfoBloc(this.lessonApiRepo, this.authSharedRepository)
//       : super(TestScreenInitialState()) {
//     on<LessonInfoLoadEvent>(_onCourseInfoLoad);
//   }

//   void loadLesson(int id) {
//     add(LessonInfoLoadEvent(id: id));
//   }

//   Future<void> _onCourseInfoLoad(
//       LessonInfoLoadEvent event, Emitter<TestScreenState> emit) async {
//     emit(TestScreenLoadingState());
//     try {
//       final lesson = await lessonApiRepo.getOne(event.id);

//       // if (course.teacherId == authSharedRepository.getId()) {
//         emit(TestScreenLoadedState(lesson: lesson, isOwner: true));
//       // } else {
//       //   emit(LessonInfoLoadedState(course: course, isOwner: false));
//       // }
//     } catch (e) {
//       debugPrint(e.toString());
//       debugPrint("||| error |||");
//       emit(TestScreenErrorState(e.toString()));
//     }
//   }
// }
