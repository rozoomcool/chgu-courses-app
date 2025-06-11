// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_option_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateOptionRequest _$CreateOptionRequestFromJson(Map<String, dynamic> json) =>
    CreateOptionRequest(
      option: json['option'] as String,
      testStageId: (json['testStageId'] as num).toInt(),
      isCorrect: json['isCorrect'] as bool,
    );

Map<String, dynamic> _$CreateOptionRequestToJson(
        CreateOptionRequest instance) =>
    <String, dynamic>{
      'option': instance.option,
      'testStageId': instance.testStageId,
      'isCorrect': instance.isCorrect,
    };
