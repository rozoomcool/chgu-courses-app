// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_lesson_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateLessonRequest _$CreateLessonRequestFromJson(Map<String, dynamic> json) =>
    CreateLessonRequest(
      title: json['title'] as String,
      lecture: json['lecture'] as String?,
      chapterId: (json['chapterId'] as num).toInt(),
    );

Map<String, dynamic> _$CreateLessonRequestToJson(
        CreateLessonRequest instance) =>
    <String, dynamic>{
      'title': instance.title,
      'lecture': instance.lecture,
      'chapterId': instance.chapterId,
    };
