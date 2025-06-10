// export class UpdateTestDto {
//   @IsOptional()
//   @IsNumber()
//   lessonId?: number;
// }

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
import 'package:json_annotation/json_annotation.dart';

part 'create_test_request.g.dart';

@JsonSerializable()
class CreateTestRequest {
  final int? lessonId;

  CreateTestRequest({
    required this.lessonId,
  });

  factory CreateTestRequest.fromJson(Map<String, dynamic> json) => _$CreateTestRequestFromJson(json);
  Map<String, dynamic> toJson() => _$CreateTestRequestToJson(this);
}