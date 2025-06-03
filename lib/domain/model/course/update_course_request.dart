import 'package:json_annotation/json_annotation.dart';

part 'update_course_request.g.dart';

@JsonSerializable()
class UpdateCourseRequest {
  final String? title;
  final String? description;
  final String? imageUrl;

  UpdateCourseRequest({this.title, this.description, this.imageUrl});

  factory UpdateCourseRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateCourseRequestFromJson(json);
  Map<String, dynamic> toJson() => _$UpdateCourseRequestToJson(this);
}
