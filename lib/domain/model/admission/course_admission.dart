import 'package:coursera/domain/model/course/course.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'course_admission.g.dart';

@JsonSerializable()
class CourseAdmission {
  const CourseAdmission({
    required this.userId,
    required this.courseId,
    this.course,
    required this.admissionState
  });

  final int userId;
  final int courseId;
  final Course? course;
  final AdmissionState admissionState;

  factory CourseAdmission.fromJson(Map<String, Object?> json) =>
      _$CourseAdmissionFromJson(json);
  
  Map<String, dynamic> toJson() => _$CourseAdmissionToJson(this);
}

enum AdmissionState {
  ACCEPTED,
  REJECTED
}