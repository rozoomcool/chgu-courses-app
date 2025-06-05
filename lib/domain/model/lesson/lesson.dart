import 'package:coursera/domain/model/lessonAttachment/lesson_attachment.dart';
import 'package:coursera/domain/model/test/test.dart';
import 'package:json_annotation/json_annotation.dart';

part 'lesson.g.dart';

@JsonSerializable()
class Lesson {
  final int id;
  final String title;
  final String? lecture;
  final Test? test;
  final List<LessonAttachment>? attachments;
  final int courseId;

  Lesson({
    required this.id,
    required this.title,
    this.lecture,
    this.test,
    required this.attachments,
    required this.courseId,
  });

  factory Lesson.fromJson(Map<String, dynamic> json) => _$LessonFromJson(json);
  Map<String, dynamic> toJson() => _$LessonToJson(this);
}