import 'package:json_annotation/json_annotation.dart';
import 'lesson_attachment_type.dart';

part 'lesson_attachment.g.dart';

@JsonSerializable()
class LessonAttachment {
  final int id;
  final String url;
  final LessonAttachmentType attachmentType;
  final int lessonId;

  LessonAttachment({
    required this.id,
    required this.url,
    required this.attachmentType,
    required this.lessonId,
  });

  factory LessonAttachment.fromJson(Map<String, dynamic> json) => _$LessonAttachmentFromJson(json);
  Map<String, dynamic> toJson() => _$LessonAttachmentToJson(this);
}
