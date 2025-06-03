// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_lesson_attachment_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateLessonAttachmentRequest _$UpdateLessonAttachmentRequestFromJson(
        Map<String, dynamic> json) =>
    UpdateLessonAttachmentRequest(
      url: json['url'] as String?,
      attachmentType: $enumDecodeNullable(
          _$LessonAttachmentTypeEnumMap, json['attachmentType']),
    );

Map<String, dynamic> _$UpdateLessonAttachmentRequestToJson(
        UpdateLessonAttachmentRequest instance) =>
    <String, dynamic>{
      'url': instance.url,
      'attachmentType': _$LessonAttachmentTypeEnumMap[instance.attachmentType],
    };

const _$LessonAttachmentTypeEnumMap = {
  LessonAttachmentType.video: 'video',
  LessonAttachmentType.file: 'file',
  LessonAttachmentType.link: 'link',
};
