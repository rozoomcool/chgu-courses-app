import 'package:coursera/domain/model/option/option.dart';
import 'package:coursera/domain/model/testStage/testStageType.dart';
import 'package:json_annotation/json_annotation.dart';

part 'test_stage.g.dart';

@JsonSerializable()
class TestStage {
  final int id;
  final int testId;
  final TestStageType type;
  final List<Option> options;
  final String question;

  TestStage({
    required this.id,
    required this.testId,
    required this.type,
    required this.options,
    required this.question,
  });

  factory TestStage.fromJson(Map<String, dynamic> json) => _$TestStageFromJson(json);
  Map<String, dynamic> toJson() => _$TestStageToJson(this);
}