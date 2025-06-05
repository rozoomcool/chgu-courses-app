import 'dart:io';

import 'package:coursera/domain/api/course/course_api_client.dart';
import 'package:coursera/domain/model/course/course.dart';
import 'package:coursera/domain/model/course/update_course_request.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'course_event.dart';
part 'course_state.dart';

class CourseBloc extends Bloc<CourseEvent, CourseState> {
  final CourseApiClient repository;

  CourseBloc(this.repository) : super(CourseInitial()) {
    on<LoadCourses>(_onLoadCourses);
    on<AddCourse>(_onAddCourse);
    // on<UpdateCourse>(_onUpdateCourse);
    on<DeleteCourse>(_onDeleteCourse);
  }

  void init() {
    debugPrint("||||||");
    print("lfdgsgfdsg");
    loadCourses();
  }

  void loadCourses() {
    add(LoadCourses());
  }

  Future<void> _onLoadCourses(
      LoadCourses event, Emitter<CourseState> emit) async {
    emit(CourseLoading());
    try {
      final request = await repository.getCourses();
      emit(CourseLoaded(request));
    } catch (e) {
      debugPrint(e.toString());
      debugPrint("||| error |||");
      emit(CourseError(e.toString()));
    }
  }

  Future<void> _onAddCourse(AddCourse event, Emitter<CourseState> emit) async {
    try {
      await repository.createCourse(event.file, event.title, event.description);
      add(LoadCourses());
    } catch (e) {
      emit(CourseError(e.toString()));
    }
  }

  // Future<void> _onUpdateCourse(
  //     UpdateCourse event, Emitter<CourseState> emit) async {
  //   try {
  //     await repository.updateCourse(event.id, event.course);
  //     add(LoadCourses());
  //   } catch (e) {
  //     emit(CourseError(e.toString()));
  //   }
  // }

  Future<void> _onDeleteCourse(
      DeleteCourse event, Emitter<CourseState> emit) async {
    try {
      await repository.deleteCourse(event.courseId);
      add(LoadCourses());
    } catch (e) {
      emit(CourseError(e.toString()));
    }
  }
}
