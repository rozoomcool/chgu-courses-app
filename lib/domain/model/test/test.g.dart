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
      ownerId: (json['ownerId'] as num).toInt(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$TestToJson(Test instance) => <String, dynamic>{
      'id': instance.id,
      'lessonId': instance.lessonId,
      'ownerId': instance.ownerId,
      'testStages': instance.testStages,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
