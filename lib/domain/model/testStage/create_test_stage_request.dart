// export class CreateTestStageDto {
//   @IsNotEmpty()
//   @IsNumber()
//   testId: number;

//   @IsOptional()
//   @IsEnum(TestStageType)
//   type?: TestStageType;

//   @IsNotEmpty()
//   @IsString()
//   question: string;

//   @IsNotEmpty()
//   @IsNumber()
//   answerId: number;
// }

import 'package:coursera/domain/model/testStage/testStageType.dart';
import 'package:json_annotation/json_annotation.dart';

part 'create_test_stage_request.g.dart';

@JsonSerializable()
class CreateTestStageRequest {
  final int testId;
  final TestStageType type;
  final String question;

  CreateTestStageRequest({
    required this.testId,
    required this.type,
    required this.question,
  });

  factory CreateTestStageRequest.fromJson(Map<String, dynamic> json) => _$CreateTestStageRequestFromJson(json);
  Map<String, dynamic> toJson() => _$CreateTestStageRequestToJson(this);
}