// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProjectDtoImpl _$$ProjectDtoImplFromJson(Map<String, dynamic> json) =>
    _$ProjectDtoImpl(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String,
      description: json['description'] as String,
      requirements: (json['requirements'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      startDate: json['startDate'] as String,
      endDate: json['endDate'] as String,
      deadline: json['deadline'] as String,
      professorId: (json['professorId'] as num).toInt(),
    );

Map<String, dynamic> _$$ProjectDtoImplToJson(_$ProjectDtoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'requirements': instance.requirements,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'deadline': instance.deadline,
      'professorId': instance.professorId,
    };
