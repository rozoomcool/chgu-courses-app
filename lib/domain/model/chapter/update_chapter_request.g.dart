// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_chapter_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateChapterRequest _$UpdateChapterRequestFromJson(
        Map<String, dynamic> json) =>
    UpdateChapterRequest(
      title: json['title'] as String?,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$UpdateChapterRequestToJson(
        UpdateChapterRequest instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
    };
