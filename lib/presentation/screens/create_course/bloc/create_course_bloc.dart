import 'dart:io';

import 'package:coursera/domain/api/course/course_api_client.dart';
import 'package:coursera/domain/model/course/course.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'create_course_event.dart';
part 'create_course_state.dart';

class CreateCourseBloc extends Bloc<CreateCourseEvent, CreateCourseState> {
  final CourseApiClient courseApiRepo;

  CreateCourseBloc(this.courseApiRepo) : super(CreateCourseInitialState()) {
    on<CreateCourseCreateEvent>(_onCreateCourse);
    on<CreateCourseLoadEvent>(_onCourseLoad);
    on<CreateCourseUpdateEvent>(_onCourseUpdate);
  }

  void createCourse(
      {required File file,
      required String title,
      required String description}) {
    debugPrint("||| createCourse");
    add(CreateCourseCreateEvent(
        file: file, title: title, description: description));
  }

  void updateCourse(
      {required int id, File? file, String? title, String? description}) {
    debugPrint("||| updateCourse");
    add(CreateCourseUpdateEvent(
        id: id, file: file, title: title, description: description));
  }

  void loadCourse(int id) {
    add(CreateCourseLoadEvent(id: id));
  }

  Future<void> _onCourseUpdate(
      CreateCourseUpdateEvent event, Emitter<CreateCourseState> emit) async {
    emit(CreateCourseLoadingState());
    try {
      final course = await courseApiRepo.updateCourse(
          id: event.id,
          file: event.file,
          title: event.title,
          description: event.description);

      emit(CreateCourseUpdatedState(course: course));
    } catch (e) {
      debugPrint(e.toString());
      debugPrint("||| error |||");
      emit(CreateCourseErrorState(e.toString()));
    }
  }

  Future<void> _onCourseLoad(
      CreateCourseLoadEvent event, Emitter<CreateCourseState> emit) async {
    emit(CreateCourseLoadingState());
    try {
      final course = await courseApiRepo.getCourse(event.id,
          teacher: false, students: false, lessons: false);

      emit(CreateCourseLoadedState(course: course));
    } catch (e) {
      debugPrint(e.toString());
      debugPrint("||| error |||");
      emit(CreateCourseErrorState(e.toString()));
    }
  }

  Future<void> _onCreateCourse(
      CreateCourseCreateEvent event, Emitter<CreateCourseState> emit) async {
    emit(CreateCourseLoadingState());
    try {
      final response = await courseApiRepo.createCourse(
          event.file, event.title, event.description);

      if (response.response.statusCode == 200 ||
          response.response.statusCode == 201) {
        emit(CreateCourseCreatedState(course: response.data));
      } else {
        debugPrint("||| error: ${response.response.statusCode.toString()} |||");
        emit(
            CreateCourseErrorState(response.response.statusMessage.toString()));
      }
    } on DioException catch (e) {
      debugPrint("||| error ${e.message} |||");
      emit(CreateCourseErrorState(e.toString()));
    } catch (e) {
      debugPrint("||| error: $e |||");
      emit(CreateCourseErrorState(e.toString()));
    }
  }
}
