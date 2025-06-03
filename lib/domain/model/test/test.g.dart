// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'test.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Test _$TestFromJson(Map<String, dynamic> json) => Test(
      id: (json['id'] as num).toInt(),
      lessonId: (json['lessonId'] as num?)?.toInt(),
      testStages: (json['testStages'] as List<dynamic>)
          .map((e) => TestStage.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TestToJson(Test instance) => <String, dynamic>{
      'id': instance.id,
      'lessonId': instance.lessonId,
      'testStages': instance.testStages,
    };
