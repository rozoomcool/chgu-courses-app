import 'package:coursera/domain/model/lesson/lesson.dart';
import 'package:json_annotation/json_annotation.dart';

part 'chapter.g.dart';

@JsonSerializable()
class Chapter {
  final int id;
  final String title;
  final String? description;
  final int courseId;
  final List<Lesson> lessons;

  Chapter({
    required this.id,
    required this.title,
    this.description,
    required this.courseId,
    required this.lessons,
  });

  factory Chapter.fromJson(Map<String, dynamic> json) => _$ChapterFromJson(json);
  Map<String, dynamic> toJson() => _$ChapterToJson(this);
}