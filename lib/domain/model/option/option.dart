import 'package:json_annotation/json_annotation.dart';

part 'option.g.dart';

@JsonSerializable()
class Option {
  final int id;
  final String option;
  final int testStageId;
  final bool isCorrect;

  Option({
    required this.id,
    required this.option,
    required this.testStageId,
    required this.isCorrect
  });

  factory Option.fromJson(Map<String, dynamic> json) => _$OptionFromJson(json);
  Map<String, dynamic> toJson() => _$OptionToJson(this);
}