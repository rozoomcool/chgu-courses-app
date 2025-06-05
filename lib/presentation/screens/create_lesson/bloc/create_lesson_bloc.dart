import 'package:coursera/domain/api/lesson/lesson_api_client.dart';
import 'package:coursera/domain/model/lesson/create_lesson_request.dart';
import 'package:coursera/domain/model/lesson/lesson.dart';
import 'package:coursera/domain/model/lesson/update_lesson_request.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'create_lesson_state.dart';
part 'create_lesson_event.dart';

class CreateLessonBloc extends Bloc<CreateLessonEvent, CreateLessonState> {
  final LessonApiClient repository;

  CreateLessonBloc(this.repository) : super(CreateLessonInitialState()) {
    on<CreateLessonLoadEvent>(_onLoadLesson);
    on<CreateLessonSaveChangeEvent>(_onSaveChanges);
    // on<AddCourse>(_onAddCourse);
    // // on<UpdateCourse>(_onUpdateCourse);
    // on<DeleteCourse>(_onDeleteCourse);
  }

  void loadLesson(int? id) {
    add(CreateLessonLoadEvent(id: id));
  }

  void update(
      {required int courseId,
      int? lessonId,
      required String title,
      required String lecture}) {
    add(CreateLessonSaveChangeEvent(
        id: lessonId, courseId: courseId, title: title, lecture: lecture));
  }

  Future<void> _onLoadLesson(
      CreateLessonLoadEvent event, Emitter<CreateLessonState> emit) async {
    emit(CreateLessonLoadingState());
    try {
      if (event.id == null) {
        emit(CreateLessonLoadedState(lesson: null));
        return;
      }
      final lesson = await repository.getOne(event.id!);
      emit(CreateLessonLoadedState(lesson: lesson));
    } catch (e) {
      debugPrint("||| error: ${e.toString()}");
      emit(CreateLessonErrorState(e.toString()));
    }
  }

  Future<void> _onSaveChanges(CreateLessonSaveChangeEvent event,
      Emitter<CreateLessonState> emit) async {
    // debugPrint("||| start _onSaveChanges");
    // if (state is! CreateLessonLoadedState) return;
    // debugPrint("||| to start _onSaveChanges");
    debugPrint("||| state $state");

    // try {
      final lessonId = (state as CreateLessonLoadedState).lesson?.id;
      emit(CreateLessonLoadingState());
      if (lessonId == null) {
        final lesson = await repository.create(CreateLessonRequest(
            title: event.title,
            courseId: event.courseId,
            lecture: event.lecture));
        emit(CreateLessonLoadedState(lesson: lesson));
        return;
      } else {
        final lesson = await repository.update(
            lessonId,
            UpdateLessonRequest(
                courseId: event.courseId,
                title: event.title,
                lecture: event.lecture));
        emit(CreateLessonLoadedState(lesson: lesson));
      }
    // } catch (e) {
    //   debugPrint("||| error: ${e.toString()}");
    //   emit(CreateLessonErrorState(e.toString()));
    // }
  }

  // Future<void> _onLoadCourses(
  //     LoadCourses event, Emitter<CourseState> emit) async {
  //   emit(CourseLoading());
  //   try {
  //     final request = await repository.getCourses();
  //     emit(CourseLoaded(request));
  //   } catch (e) {
  //     debugPrint(e.toString());
  //     debugPrint("||| error |||");
  //     emit(CourseError(e.toString()));
  //   }
  // }

  // Future<void> _onAddCourse(AddCourse event, Emitter<CourseState> emit) async {
  //   try {
  //     await repository.createCourse(event.file, event.title, event.description);
  //     add(LoadCourses());
  //   } catch (e) {
  //     emit(CourseError(e.toString()));
  //   }
  // }

  // // Future<void> _onUpdateCourse(
  // //     UpdateCourse event, Emitter<CourseState> emit) async {
  // //   try {
  // //     await repository.updateCourse(event.id, event.course);
  // //     add(LoadCourses());
  // //   } catch (e) {
  // //     emit(CourseError(e.toString()));
  // //   }
  // // }

  // Future<void> _onDeleteCourse(
  //     DeleteCourse event, Emitter<CourseState> emit) async {
  //   try {
  //     await repository.deleteCourse(event.courseId);
  //     add(LoadCourses());
  //   } catch (e) {
  //     emit(CourseError(e.toString()));
  //   }
  // }
}
