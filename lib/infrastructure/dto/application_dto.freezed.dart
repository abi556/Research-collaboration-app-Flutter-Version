// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'application_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ApplicationDto _$ApplicationDtoFromJson(Map<String, dynamic> json) {
  return _ApplicationDto.fromJson(json);
}

/// @nodoc
mixin _$ApplicationDto {
  int get id => throw _privateConstructorUsedError;
  int get studentId => throw _privateConstructorUsedError;
  int get projectId => throw _privateConstructorUsedError;
  ApplicationStatus get status => throw _privateConstructorUsedError;

  /// Serializes this ApplicationDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ApplicationDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ApplicationDtoCopyWith<ApplicationDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ApplicationDtoCopyWith<$Res> {
  factory $ApplicationDtoCopyWith(
          ApplicationDto value, $Res Function(ApplicationDto) then) =
      _$ApplicationDtoCopyWithImpl<$Res, ApplicationDto>;
  @useResult
  $Res call({int id, int studentId, int projectId, ApplicationStatus status});
}

/// @nodoc
class _$ApplicationDtoCopyWithImpl<$Res, $Val extends ApplicationDto>
    implements $ApplicationDtoCopyWith<$Res> {
  _$ApplicationDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ApplicationDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? studentId = null,
    Object? projectId = null,
    Object? status = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      studentId: null == studentId
          ? _value.studentId
          : studentId // ignore: cast_nullable_to_non_nullable
              as int,
      projectId: null == projectId
          ? _value.projectId
          : projectId // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ApplicationStatus,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ApplicationDtoImplCopyWith<$Res>
    implements $ApplicationDtoCopyWith<$Res> {
  factory _$$ApplicationDtoImplCopyWith(_$ApplicationDtoImpl value,
          $Res Function(_$ApplicationDtoImpl) then) =
      __$$ApplicationDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, int studentId, int projectId, ApplicationStatus status});
}

/// @nodoc
class __$$ApplicationDtoImplCopyWithImpl<$Res>
    extends _$ApplicationDtoCopyWithImpl<$Res, _$ApplicationDtoImpl>
    implements _$$ApplicationDtoImplCopyWith<$Res> {
  __$$ApplicationDtoImplCopyWithImpl(
      _$ApplicationDtoImpl _value, $Res Function(_$ApplicationDtoImpl) _then)
      : super(_value, _then);

  /// Create a copy of ApplicationDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? studentId = null,
    Object? projectId = null,
    Object? status = null,
  }) {
    return _then(_$ApplicationDtoImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      studentId: null == studentId
          ? _value.studentId
          : studentId // ignore: cast_nullable_to_non_nullable
              as int,
      projectId: null == projectId
          ? _value.projectId
          : projectId // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ApplicationStatus,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ApplicationDtoImpl implements _ApplicationDto {
  const _$ApplicationDtoImpl(
      {required this.id,
      required this.studentId,
      required this.projectId,
      required this.status});

  factory _$ApplicationDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$ApplicationDtoImplFromJson(json);

  @override
  final int id;
  @override
  final int studentId;
  @override
  final int projectId;
  @override
  final ApplicationStatus status;

  @override
  String toString() {
    return 'ApplicationDto(id: $id, studentId: $studentId, projectId: $projectId, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ApplicationDtoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.studentId, studentId) ||
                other.studentId == studentId) &&
            (identical(other.projectId, projectId) ||
                other.projectId == projectId) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, studentId, projectId, status);

  /// Create a copy of ApplicationDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ApplicationDtoImplCopyWith<_$ApplicationDtoImpl> get copyWith =>
      __$$ApplicationDtoImplCopyWithImpl<_$ApplicationDtoImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ApplicationDtoImplToJson(
      this,
    );
  }
}

abstract class _ApplicationDto implements ApplicationDto {
  const factory _ApplicationDto(
      {required final int id,
      required final int studentId,
      required final int projectId,
      required final ApplicationStatus status}) = _$ApplicationDtoImpl;

  factory _ApplicationDto.fromJson(Map<String, dynamic> json) =
      _$ApplicationDtoImpl.fromJson;

  @override
  int get id;
  @override
  int get studentId;
  @override
  int get projectId;
  @override
  ApplicationStatus get status;

  /// Create a copy of ApplicationDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ApplicationDtoImplCopyWith<_$ApplicationDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
