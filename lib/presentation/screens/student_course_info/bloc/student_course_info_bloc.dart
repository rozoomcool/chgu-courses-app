import 'package:coursera/domain/api/course/course_api_client.dart';
import 'package:coursera/domain/model/admission/course_admission.dart';
import 'package:coursera/domain/model/course/course.dart';
import 'package:coursera/repository/shared/auth_shared_repository.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'student_course_info_event.dart';
part 'student_course_info_state.dart';

class StudentCourseInfoBloc
    extends Bloc<StudentCourseInfoEvent, StudentCourseInfoState> {
  final CourseApiClient courseApiRepo;
  final AuthSharedRepository authSharedRepository;

  StudentCourseInfoBloc(this.courseApiRepo, this.authSharedRepository)
      : super(StudentCourseInfoInitialState()) {
    on<StudentCourseInfoLoadEvent>(_onCourseInfoLoad);
    on<StudentCourseInfoAddAdmissionEvent>(_onCourseInfoAddAdmission);
  }

  void loadCourse(int id) {
    add(StudentCourseInfoLoadEvent(id: id));
  }

  void addAdmission(int courseId) {
    add(StudentCourseInfoAddAdmissionEvent(courseId: courseId));
  }

  Future<void> _onCourseInfoLoad(StudentCourseInfoLoadEvent event,
      Emitter<StudentCourseInfoState> emit) async {
    emit(StudentCourseInfoLoadingState());
    try {
      final course =
          await courseApiRepo.getCourse(event.id, teacher: true, lessons: true);
      final admission = await courseApiRepo.getMyAdmission(courseId: course.id);

      emit(StudentCourseInfoLoadedState(course: course, admission: admission));
    } catch (e) {
      debugPrint(e.toString());
      debugPrint("||| error |||");
      emit(StudentCourseInfoErrorState(e.toString()));
    }
  }

  Future<void> _onCourseInfoAddAdmission(
      StudentCourseInfoAddAdmissionEvent event,
      Emitter<StudentCourseInfoState> emit) async {
    emit(StudentCourseInfoLoadingState());
    try {
      final admission = await courseApiRepo.addAdmission(event.courseId);
      final course = await courseApiRepo.getCourse(event.courseId,
          teacher: true, lessons: true);

      emit(StudentCourseInfoLoadedState(course: course, admission: admission));
    } catch (e) {
      debugPrint(e.toString());
      debugPrint("||| error |||");
      emit(StudentCourseInfoErrorState(e.toString()));
    }
  }
}
