// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_test_stage_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateTestStageRequest _$CreateTestStageRequestFromJson(
        Map<String, dynamic> json) =>
    CreateTestStageRequest(
      testId: (json['testId'] as num).toInt(),
      type: $enumDecode(_$TestStageTypeEnumMap, json['type']),
      question: json['question'] as String,
    );

Map<String, dynamic> _$CreateTestStageRequestToJson(
        CreateTestStageRequest instance) =>
    <String, dynamic>{
      'testId': instance.testId,
      'type': _$TestStageTypeEnumMap[instance.type]!,
      'question': instance.question,
    };

const _$TestStageTypeEnumMap = {
  TestStageType.OPTIONAL: 'OPTIONAL',
  TestStageType.MANUAL: 'MANUAL',
};
