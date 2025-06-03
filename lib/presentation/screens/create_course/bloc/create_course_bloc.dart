import 'dart:io';

import 'package:coursera/domain/api/course/course_api_client.dart';
import 'package:coursera/domain/api/user/user_api_client.dart';
import 'package:coursera/domain/model/course/course.dart';
import 'package:coursera/domain/model/course/update_course_request.dart';
import 'package:coursera/domain/model/profile/profile.dart';
import 'package:coursera/domain/model/user/user.dart';
import 'package:coursera/presentation/screens/profile/profile_screen.dart';
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

  void init() {
    debugPrint("||||||");
    loadCourses();
  }

  void loadCourses() {
    add(CreateCourseCreateEvent());
  }

  Future<void> _onCreateCourse(
      CreateCourseCreateEvent event, Emitter<CreateCourseState> emit) async {
    // emit(ProfileScreenLoadingState());
    // try {
    //   final user = await userApiRepo.findOne();
    //   final courses = await courseApiRepo.getByTeacherId(user.id);
    //   // debugPrint(request.toString());
    //   emit(ProfileScreenLoadedState(
    //       user: user, profile: user.profile!, courses: courses));
    // } catch (e) {
    //   debugPrint(e.toString());
    //   debugPrint("||| error |||");
    //   emit(ProfileScreenErrorState(e.toString()));
    // }
  }
}
