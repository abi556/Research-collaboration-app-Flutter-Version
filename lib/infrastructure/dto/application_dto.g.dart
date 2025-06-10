// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'application_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ApplicationDtoImpl _$$ApplicationDtoImplFromJson(Map<String, dynamic> json) =>
    _$ApplicationDtoImpl(
      id: (json['id'] as num).toInt(),
      studentId: (json['studentId'] as num).toInt(),
      projectId: (json['projectId'] as num).toInt(),
      status: $enumDecode(_$ApplicationStatusEnumMap, json['status']),
    );

Map<String, dynamic> _$$ApplicationDtoImplToJson(
  _$ApplicationDtoImpl instance,
) => <String, dynamic>{
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
