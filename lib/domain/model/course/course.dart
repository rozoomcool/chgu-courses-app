import 'package:coursera/domain/model/lesson/lesson.dart';
import 'package:json_annotation/json_annotation.dart';

part 'course.g.dart';

@JsonSerializable()
class Course {
  final int id;
  final String title;
  final String description;
  final int teacherId;
  final String? imageUrl;
  final List<Lesson>? lessons;
  final Complexity complexity;

  Course({
    required this.id,
    required this.title,
    required this.description,
    required this.teacherId,
    this.imageUrl,
    required this.lessons,
    required this.complexity,
  });

  factory Course.fromJson(Map<String, dynamic> json) => _$CourseFromJson(json);
  Map<String, dynamic> toJson() => _$CourseToJson(this);
}

enum Complexity {
  EASY,
  MEDIUM,
  HARD,
}
