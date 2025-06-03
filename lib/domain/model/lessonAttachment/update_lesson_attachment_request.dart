import 'package:json_annotation/json_annotation.dart';
import 'lesson_attachment_type.dart';

part 'update_lesson_attachment_request.g.dart';

@JsonSerializable()
class UpdateLessonAttachmentRequest {
  final String? url;
  final LessonAttachmentType? attachmentType;

  UpdateLessonAttachmentRequest({this.url, this.attachmentType});

  factory UpdateLessonAttachmentRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateLessonAttachmentRequestFromJson(json);
  Map<String, dynamic> toJson() => _$UpdateLessonAttachmentRequestToJson(this);
}
