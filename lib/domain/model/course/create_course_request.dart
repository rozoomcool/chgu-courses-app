import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_course_request.g.dart';

@JsonSerializable()
class CreateCourseRequest {
  final String title;
  final String description;
  final String? imageUrl;

  CreateCourseRequest({
    required this.title,
    required this.description,
    this.imageUrl,
  });

  factory CreateCourseRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateCourseRequestFromJson(json);
  Map<String, dynamic> toJson() => _$CreateCourseRequestToJson(this);
}