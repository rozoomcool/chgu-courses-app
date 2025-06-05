// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_lesson_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateLessonRequest _$UpdateLessonRequestFromJson(Map<String, dynamic> json) =>
    UpdateLessonRequest(
      courseId: (json['courseId'] as num).toInt(),
      title: json['title'] as String?,
      lecture: json['lecture'] as String?,
    );

Map<String, dynamic> _$UpdateLessonRequestToJson(
        UpdateLessonRequest instance) =>
    <String, dynamic>{
      'courseId': instance.courseId,
      'title': instance.title,
      'lecture': instance.lecture,
    };
