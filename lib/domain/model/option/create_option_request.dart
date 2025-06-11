import 'package:json_annotation/json_annotation.dart';

part 'create_option_request.g.dart';

@JsonSerializable()
class CreateOptionRequest {
  final String option;
  final int testStageId;
  final bool isCorrect;

  CreateOptionRequest({
    required this.option,
    required this.testStageId,
    required this.isCorrect,
  });

  factory CreateOptionRequest.fromJson(Map<String, dynamic> json) => _$CreateOptionRequestFromJson(json);
  Map<String, dynamic> toJson() => _$CreateOptionRequestToJson(this);
}