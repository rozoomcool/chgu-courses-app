import 'package:json_annotation/json_annotation.dart';

part 'create_chapter_request.g.dart';

@JsonSerializable()
class CreateChapterRequest {
  final String title;
  final String? description;
  final int courseId;

  CreateChapterRequest({
    required this.title,
    this.description,
    required this.courseId,
  });

  factory CreateChapterRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateChapterRequestFromJson(json);
  Map<String, dynamic> toJson() => _$CreateChapterRequestToJson(this);
}