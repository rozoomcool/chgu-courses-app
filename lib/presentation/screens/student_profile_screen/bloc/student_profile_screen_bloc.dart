import 'package:coursera/domain/api/course/course_api_client.dart';
import 'package:coursera/domain/api/user/user_api_client.dart';
import 'package:coursera/domain/model/admission/course_admission.dart';
import 'package:coursera/domain/model/course/course.dart';
import 'package:coursera/domain/model/profile/profile.dart';
import 'package:coursera/domain/model/user/user.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'student_profile_screen_event.dart';
part 'student_profile_screen_state.dart';

class StudentProfileScreenBloc
    extends Bloc<StudentProfileScreenEvent, StudentProfileScreenState> {
  final CourseApiClient courseApiRepo;
  final UserApiClient userApiRepo;

  StudentProfileScreenBloc(this.courseApiRepo, this.userApiRepo)
      : super(ProfileScreenInitialState()) {
    on<StudentProfileScreenLoadEvent>(_onLoadProfile);
  }

  void init() {
    debugPrint("||||||");
    loadData();
  }

  void loadData() {
    add(StudentProfileScreenLoadEvent());
  }

  Future<void> _onLoadProfile(StudentProfileScreenLoadEvent event,
      Emitter<StudentProfileScreenState> emit) async {
    emit(StudentProfileScreenLoadingState());
    try {
      // await Future.delayed(Duration(milliseconds: 500));
      debugPrint("||| student");
      final user = await userApiRepo.findOne();
      debugPrint("||| student user");
      final admissions = await courseApiRepo.getAllAdmissionsByUser();
      debugPrint("||| admissions");
      emit(StudentProfileScreenLoadedState(
        user: user,
        profile: user.profile!,
        admissions: admissions,
      ));
    } catch (e) {
      debugPrint(e.toString());
      debugPrint("||| error |||");
      emit(StudentProfileScreenErrorState(e.toString()));
    }
  }
}
