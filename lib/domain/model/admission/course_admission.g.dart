// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_admission.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourseAdmission _$CourseAdmissionFromJson(Map<String, dynamic> json) =>
    CourseAdmission(
      userId: (json['userId'] as num).toInt(),
      courseId: (json['courseId'] as num).toInt(),
      course: json['course'] == null
          ? null
          : Course.fromJson(json['course'] as Map<String, dynamic>),
      admissionState:
          $enumDecode(_$AdmissionStateEnumMap, json['admissionState']),
    );

Map<String, dynamic> _$CourseAdmissionToJson(CourseAdmission instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'courseId': instance.courseId,
      'course': instance.course,
      'admissionState': _$AdmissionStateEnumMap[instance.admissionState]!,
    };

const _$AdmissionStateEnumMap = {
  AdmissionState.ACCEPTED: 'ACCEPTED',
  AdmissionState.REJECTED: 'REJECTED',
};
