import 'package:coursera/domain/api/course/course_api_client.dart';
import 'package:coursera/domain/model/course/course.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'course_info_event.dart';
part 'course_info_state.dart';

class CourseInfoBloc extends Bloc<CourseInfoEvent, CourseInfoState> {
  final CourseApiClient courseApiRepo;

  CourseInfoBloc(this.courseApiRepo) : super(CourseInfoInitialState()) {
    // on<CreateCourseCreateEvent>(_onCreateCourse);
  }

  void init() {
    debugPrint("||||||");
    loadCourses();
  }

  void loadCourses() {
    // add(CreateCourseCreateEvent());
  }

  // Future<void> _onCreateCourse(
      // CreateCourseCreateEvent event, Emitter<CreateCourseState> emit) async {
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
  // }
}
