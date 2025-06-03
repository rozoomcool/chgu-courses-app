// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_course_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateCourseRequest _$UpdateCourseRequestFromJson(Map<String, dynamic> json) =>
    UpdateCourseRequest(
      title: json['title'] as String?,
      description: json['description'] as String?,
      imageUrl: json['imageUrl'] as String?,
    );

Map<String, dynamic> _$UpdateCourseRequestToJson(
        UpdateCourseRequest instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'imageUrl': instance.imageUrl,
    };
