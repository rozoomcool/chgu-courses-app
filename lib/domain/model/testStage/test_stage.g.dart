// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'test_stage.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TestStage _$TestStageFromJson(Map<String, dynamic> json) => TestStage(
      id: (json['id'] as num).toInt(),
      testId: (json['testId'] as num).toInt(),
      type: $enumDecode(_$TestStageTypeEnumMap, json['type']),
      options: (json['options'] as List<dynamic>)
          .map((e) => Option.fromJson(e as Map<String, dynamic>))
          .toList(),
      question: json['question'] as String,
    );

Map<String, dynamic> _$TestStageToJson(TestStage instance) => <String, dynamic>{
      'id': instance.id,
      'testId': instance.testId,
      'type': _$TestStageTypeEnumMap[instance.type]!,
      'options': instance.options,
      'question': instance.question,
    };

const _$TestStageTypeEnumMap = {
  TestStageType.OPTIONAL: 'OPTIONAL',
  TestStageType.MANUAL: 'MANUAL',
};
