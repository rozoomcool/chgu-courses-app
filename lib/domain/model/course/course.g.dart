// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Course _$CourseFromJson(Map<String, dynamic> json) => Course(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      description: json['description'] as String,
      teacherId: (json['teacherId'] as num).toInt(),
      imageUrl: json['imageUrl'] as String?,
      lessons: (json['lessons'] as List<dynamic>?)
          ?.map((e) => Lesson.fromJson(e as Map<String, dynamic>))
          .toList(),
      complexity: $enumDecode(_$ComplexityEnumMap, json['complexity']),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$CourseToJson(Course instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'teacherId': instance.teacherId,
      'imageUrl': instance.imageUrl,
      'lessons': instance.lessons,
      'complexity': _$ComplexityEnumMap[instance.complexity]!,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

const _$ComplexityEnumMap = {
  Complexity.EASY: 'EASY',
  Complexity.MEDIUM: 'MEDIUM',
  Complexity.HARD: 'HARD',
};
