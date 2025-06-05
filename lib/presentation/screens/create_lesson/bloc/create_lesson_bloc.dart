import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'create_lesson_state.dart';
part 'create_lesson_event.dart';

class CreateLessonBloc extends Bloc<CreateLessonEvent, CreateLessonState> {
  // final CourseApiClient repository;

  CreateLessonBloc() : super(CreateLessonInitialState()) {
    // on<LoadCourses>(_onLoadCourses);
    // on<AddCourse>(_onAddCourse);
    // // on<UpdateCourse>(_onUpdateCourse);
    // on<DeleteCourse>(_onDeleteCourse);
  }

  // void init() {
  //   debugPrint("||||||");
  //   print("lfdgsgfdsg");
  //   loadCourses();
  // }

  // void loadCourses() {
  //   add(LoadCourses());
  // }

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
