// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_course_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateCourseRequest _$CreateCourseRequestFromJson(Map<String, dynamic> json) =>
    CreateCourseRequest(
      title: json['title'] as String,
      description: json['description'] as String,
      imageUrl: json['imageUrl'] as String?,
    );

Map<String, dynamic> _$CreateCourseRequestToJson(
        CreateCourseRequest instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'imageUrl': instance.imageUrl,
    };
