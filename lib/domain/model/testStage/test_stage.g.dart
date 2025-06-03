// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'test_stage.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TestStage _$TestStageFromJson(Map<String, dynamic> json) => TestStage(
      id: (json['id'] as num).toInt(),
      testId: (json['testId'] as num).toInt(),
      type: $enumDecode(_$TestStageTypeEnumMap, json['type']),
      answerId: (json['answerId'] as num).toInt(),
      options: (json['options'] as List<dynamic>)
          .map((e) => Option.fromJson(e as Map<String, dynamic>))
          .toList(),
      question: json['question'] as String,
      answer: Option.fromJson(json['answer'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TestStageToJson(TestStage instance) => <String, dynamic>{
      'id': instance.id,
      'testId': instance.testId,
      'type': _$TestStageTypeEnumMap[instance.type]!,
      'answerId': instance.answerId,
      'options': instance.options,
      'question': instance.question,
      'answer': instance.answer,
    };

const _$TestStageTypeEnumMap = {
  TestStageType.OPTIONAL: 'OPTIONAL',
  TestStageType.REQUIRED: 'REQUIRED',
};
