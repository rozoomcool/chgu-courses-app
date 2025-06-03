// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lesson.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Lesson _$LessonFromJson(Map<String, dynamic> json) => Lesson(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      lecture: json['lecture'] as String?,
      test: json['test'] == null
          ? null
          : Test.fromJson(json['test'] as Map<String, dynamic>),
      attachments: (json['attachments'] as List<dynamic>)
          .map((e) => LessonAttachment.fromJson(e as Map<String, dynamic>))
          .toList(),
      chapterId: (json['chapterId'] as num).toInt(),
    );

Map<String, dynamic> _$LessonToJson(Lesson instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'lecture': instance.lecture,
      'test': instance.test,
      'attachments': instance.attachments,
      'chapterId': instance.chapterId,
    };
