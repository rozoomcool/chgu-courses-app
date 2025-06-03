import 'package:json_annotation/json_annotation.dart';

part 'update_lesson_request.g.dart';

@JsonSerializable()
class UpdateLessonRequest {
  final String? title;
  final String? lecture;

  UpdateLessonRequest({this.title, this.lecture});

  factory UpdateLessonRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateLessonRequestFromJson(json);
  Map<String, dynamic> toJson() => _$UpdateLessonRequestToJson(this);
}
