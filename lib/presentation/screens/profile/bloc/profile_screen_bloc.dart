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

part 'profile_screen_event.dart';
part 'profile_screen_state.dart';

class ProfileScreenBloc extends Bloc<ProfileScreenEvent, ProfileScreenState> {
  final CourseApiClient courseApiRepo;
  final UserApiClient userApiRepo;

  ProfileScreenBloc(this.courseApiRepo, this.userApiRepo)
      : super(ProfileScreenInitialState()) {
    on<ProfileScreenLoadEvent>(_onLoadProfile);
  }

  void init() {
    debugPrint("||||||");
    loadCourses();
  }

  void loadCourses() {
    add(ProfileScreenLoadEvent());
  }

  Future<void> _onLoadProfile(
      ProfileScreenLoadEvent event, Emitter<ProfileScreenState> emit) async {
    emit(ProfileScreenLoadingState());
    try {
      final user = await userApiRepo.findOne();
      final courses = await courseApiRepo.getByTeacherId(user.id);
      // debugPrint(request.toString());
      emit(ProfileScreenLoadedState(
          user: user, profile: user.profile!, courses: courses));
    } catch (e) {
      debugPrint(e.toString());
      debugPrint("||| error |||");
      emit(ProfileScreenErrorState(e.toString()));
    }
  }
}
