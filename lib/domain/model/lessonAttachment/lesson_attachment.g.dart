// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lesson_attachment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LessonAttachment _$LessonAttachmentFromJson(Map<String, dynamic> json) =>
    LessonAttachment(
      id: (json['id'] as num).toInt(),
      url: json['url'] as String,
      attachmentType:
          $enumDecode(_$LessonAttachmentTypeEnumMap, json['attachmentType']),
      lessonId: (json['lessonId'] as num).toInt(),
    );

Map<String, dynamic> _$LessonAttachmentToJson(LessonAttachment instance) =>
    <String, dynamic>{
      'id': instance.id,
      'url': instance.url,
      'attachmentType': _$LessonAttachmentTypeEnumMap[instance.attachmentType]!,
      'lessonId': instance.lessonId,
    };

const _$LessonAttachmentTypeEnumMap = {
  LessonAttachmentType.video: 'video',
  LessonAttachmentType.file: 'file',
  LessonAttachmentType.link: 'link',
};
