import 'package:json_annotation/json_annotation.dart';

part 'create_lesson_request.g.dart';

@JsonSerializable()
class CreateLessonRequest {
  final String title;
  final String? lecture;
  final int courseId;

  CreateLessonRequest({
    required this.title,
    this.lecture,
    required this.courseId,
  });

  factory CreateLessonRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateLessonRequestFromJson(json);
  Map<String, dynamic> toJson() => _$CreateLessonRequestToJson(this);
}
