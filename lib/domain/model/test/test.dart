import 'package:coursera/domain/model/testStage/test_stage.dart';
import 'package:json_annotation/json_annotation.dart';

part 'test.g.dart';

@JsonSerializable()
class Test {
  final int id;
  final int? lessonId;
  final List<TestStage> testStages;

  Test({
    required this.id,
    this.lessonId,
    required this.testStages,
  });

  factory Test.fromJson(Map<String, dynamic> json) => _$TestFromJson(json);
  Map<String, dynamic> toJson() => _$TestToJson(this);
}