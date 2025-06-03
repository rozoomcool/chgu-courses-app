// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_chapter_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateChapterRequest _$CreateChapterRequestFromJson(
        Map<String, dynamic> json) =>
    CreateChapterRequest(
      title: json['title'] as String,
      description: json['description'] as String?,
      courseId: (json['courseId'] as num).toInt(),
    );

Map<String, dynamic> _$CreateChapterRequestToJson(
        CreateChapterRequest instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'courseId': instance.courseId,
    };
