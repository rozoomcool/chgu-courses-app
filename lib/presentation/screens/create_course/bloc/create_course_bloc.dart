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
  }

  void createCourse(
      {required File file,
      required String title,
      required String description}) {
    add(CreateCourseCreateEvent(
        file: file, title: title, description: description));
  }

  Future<void> _onCreateCourse(
      CreateCourseCreateEvent event, Emitter<CreateCourseState> emit) async {
    emit(CreateCourseLoadingState());
    try {
      final course = await courseApiRepo.createCourse(
          event.file, event.title, event.description);
          
      emit(CreateCourseCreatedState(course: course));
    } on DioException catch (e) {
      debugPrint("||| error ${e.message} |||");
      emit(CreateCourseErrorState(e.toString()));
    } catch (e) {
      debugPrint("||| error |||");
      emit(CreateCourseErrorState(e.toString()));
    }
  }
}
