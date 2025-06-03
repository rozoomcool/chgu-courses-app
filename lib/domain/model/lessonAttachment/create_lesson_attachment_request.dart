import 'package:coursera/domain/model/lessonAttachment/lesson_attachment_type.dart';
import 'package:json_annotation/json_annotation.dart';

part 'create_lesson_attachment_request.g.dart';

@JsonSerializable()
class CreateLessonAttachmentRequest {
  final String url;
  final LessonAttachmentType attachmentType;
  final int lessonId;

  CreateLessonAttachmentRequest({
    required this.url,
    required this.attachmentType,
    required this.lessonId,
  });

  factory CreateLessonAttachmentRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateLessonAttachmentRequestFromJson(json);
  Map<String, dynamic> toJson() => _$CreateLessonAttachmentRequestToJson(this);
}
