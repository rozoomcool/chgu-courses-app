import 'package:coursera/domain/model/testStage/test_stage.dart';
import 'package:json_annotation/json_annotation.dart';

part 'test.g.dart';

@JsonSerializable()
class Test {
  final int id;
  final int? lessonId;
  final List<TestStage> testStages;
  final DateTime createdAt;
  final DateTime updatedAt;

  Test({
    required this.id,
    this.lessonId,
    required this.testStages,
    required this.createdAt,
    required this.updatedAt
  });

  factory Test.fromJson(Map<String, dynamic> json) => _$TestFromJson(json);
  Map<String, dynamic> toJson() => _$TestToJson(this);
}