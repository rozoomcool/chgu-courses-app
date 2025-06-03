import 'package:json_annotation/json_annotation.dart';

part 'update_chapter_request.g.dart';

@JsonSerializable()
class UpdateChapterRequest {
  final String? title;
  final String? description;

  UpdateChapterRequest({this.title, this.description});

  factory UpdateChapterRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateChapterRequestFromJson(json);
  Map<String, dynamic> toJson() => _$UpdateChapterRequestToJson(this);
}
