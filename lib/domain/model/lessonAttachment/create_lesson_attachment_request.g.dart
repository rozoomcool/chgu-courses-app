// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_lesson_attachment_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateLessonAttachmentRequest _$CreateLessonAttachmentRequestFromJson(
        Map<String, dynamic> json) =>
    CreateLessonAttachmentRequest(
      url: json['url'] as String,
      attachmentType:
          $enumDecode(_$LessonAttachmentTypeEnumMap, json['attachmentType']),
      lessonId: (json['lessonId'] as num).toInt(),
    );

Map<String, dynamic> _$CreateLessonAttachmentRequestToJson(
        CreateLessonAttachmentRequest instance) =>
    <String, dynamic>{
      'url': instance.url,
      'attachmentType': _$LessonAttachmentTypeEnumMap[instance.attachmentType]!,
      'lessonId': instance.lessonId,
    };

const _$LessonAttachmentTypeEnumMap = {
  LessonAttachmentType.video: 'video',
  LessonAttachmentType.file: 'file',
  LessonAttachmentType.link: 'link',
};
