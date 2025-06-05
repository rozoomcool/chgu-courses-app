import 'package:json_annotation/json_annotation.dart';

part 'update_lesson_request.g.dart';

@JsonSerializable()
class UpdateLessonRequest {
  final int courseId;
  final String? title;
  final String? lecture;

  UpdateLessonRequest({required this.courseId, this.title, this.lecture});

  factory UpdateLessonRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateLessonRequestFromJson(json);
  Map<String, dynamic> toJson() => _$UpdateLessonRequestToJson(this);
}
