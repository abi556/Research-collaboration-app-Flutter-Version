// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'application.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ApplicationImpl _$$ApplicationImplFromJson(Map<String, dynamic> json) =>
    _$ApplicationImpl(
      id: (json['id'] as num).toInt(),
      studentId: (json['studentId'] as num).toInt(),
      projectId: (json['projectId'] as num).toInt(),
      status: $enumDecode(_$ApplicationStatusEnumMap, json['status']),
    );

Map<String, dynamic> _$$ApplicationImplToJson(_$ApplicationImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'studentId': instance.studentId,
      'projectId': instance.projectId,
      'status': _$ApplicationStatusEnumMap[instance.status]!,
    };

const _$ApplicationStatusEnumMap = {
  ApplicationStatus.PENDING: 'PENDING',
  ApplicationStatus.APPROVED: 'APPROVED',
  ApplicationStatus.REJECTED: 'REJECTED',
};
