// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserImpl _$$UserImplFromJson(Map<String, dynamic> json) => _$UserImpl(
  id: (json['id'] as num).toInt(),
  email: json['email'] as String,
  name: json['name'] as String?,
  department: json['department'] as String?,
  bio: json['bio'] as String?,
  role: $enumDecodeNullable(_$RoleEnumMap, json['role']),
  skills: (json['skills'] as List<dynamic>?)?.map((e) => e as String).toList(),
  researchInterests: json['researchInterests'] as String?,
  isActive: json['isActive'] as bool?,
);

Map<String, dynamic> _$$UserImplToJson(_$UserImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'name': instance.name,
      'department': instance.department,
      'bio': instance.bio,
      'role': _$RoleEnumMap[instance.role],
      'skills': instance.skills,
      'researchInterests': instance.researchInterests,
      'isActive': instance.isActive,
    };

const _$RoleEnumMap = {
  Role.ADMIN: 'ADMIN',
  Role.PROFESSOR: 'PROFESSOR',
  Role.STUDENT: 'STUDENT',
};
