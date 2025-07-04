import 'package:coursera/domain/api/course/course_api_client.dart';
import 'package:coursera/domain/api/user/user_api_client.dart';
import 'package:coursera/domain/model/course/course.dart';
import 'package:coursera/domain/model/profile/profile.dart';
import 'package:coursera/domain/model/user/user.dart';
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
    on<ProfileScreenDeleteEvent>(_onDeleteCourse);
  }

  void init() {
    debugPrint("||||||");
    loadData();
  }

  void loadData() {
    add(ProfileScreenLoadEvent());
  }

  void deleteCourse(int id, Function onDelete) {
    add(ProfileScreenDeleteEvent(id: id, onDeleteSuccessful: onDelete));
  }

  Future<void> _onLoadProfile(
      ProfileScreenLoadEvent event, Emitter<ProfileScreenState> emit) async {
    emit(ProfileScreenLoadingState());
    try {
      // await Future.delayed(Duration(milliseconds: 500));
      final user = await userApiRepo.findOne();
      final courses = await courseApiRepo.getByTeacherId(user.id);
      courses.sort((a, b) => a.updatedAt.compareTo(b.updatedAt),);
      // debugPrint(request.toString());
      emit(ProfileScreenLoadedState(
          user: user, profile: user.profile!, courses: courses));
    } catch (e) {
      debugPrint(e.toString());
      debugPrint("||| error |||");
      emit(ProfileScreenErrorState(e.toString()));
    }
  }

  Future<void> _onDeleteCourse(
      ProfileScreenDeleteEvent event, Emitter<ProfileScreenState> emit) async {
    try {
      await courseApiRepo.deleteCourse(event.id);
      event.onDeleteSuccessful();
    } catch (e) {
      debugPrint("||| error: $e |||");
      emit(ProfileScreenErrorState(e.toString()));
    }
  }
}
