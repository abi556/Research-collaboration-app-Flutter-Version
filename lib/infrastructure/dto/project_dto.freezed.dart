// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'project_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ProjectDto _$ProjectDtoFromJson(Map<String, dynamic> json) {
  return _ProjectDto.fromJson(json);
}

/// @nodoc
mixin _$ProjectDto {
  int get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  List<String> get requirements => throw _privateConstructorUsedError;
  String get startDate => throw _privateConstructorUsedError;
  String get endDate => throw _privateConstructorUsedError;
  String get deadline => throw _privateConstructorUsedError;

  /// Serializes this ProjectDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ProjectDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProjectDtoCopyWith<ProjectDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProjectDtoCopyWith<$Res> {
  factory $ProjectDtoCopyWith(
    ProjectDto value,
    $Res Function(ProjectDto) then,
  ) = _$ProjectDtoCopyWithImpl<$Res, ProjectDto>;
  @useResult
  $Res call({
    int id,
    String title,
    String description,
    List<String> requirements,
    String startDate,
    String endDate,
    String deadline,
  });
}

/// @nodoc
class _$ProjectDtoCopyWithImpl<$Res, $Val extends ProjectDto>
    implements $ProjectDtoCopyWith<$Res> {
  _$ProjectDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProjectDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? requirements = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? deadline = null,
  }) {
    return _then(
      _value.copyWith(
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as int,
            title:
                null == title
                    ? _value.title
                    : title // ignore: cast_nullable_to_non_nullable
                        as String,
            description:
                null == description
                    ? _value.description
                    : description // ignore: cast_nullable_to_non_nullable
                        as String,
            requirements:
                null == requirements
                    ? _value.requirements
                    : requirements // ignore: cast_nullable_to_non_nullable
                        as List<String>,
            startDate:
                null == startDate
                    ? _value.startDate
                    : startDate // ignore: cast_nullable_to_non_nullable
                        as String,
            endDate:
                null == endDate
                    ? _value.endDate
                    : endDate // ignore: cast_nullable_to_non_nullable
                        as String,
            deadline:
                null == deadline
                    ? _value.deadline
                    : deadline // ignore: cast_nullable_to_non_nullable
                        as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ProjectDtoImplCopyWith<$Res>
    implements $ProjectDtoCopyWith<$Res> {
  factory _$$ProjectDtoImplCopyWith(
    _$ProjectDtoImpl value,
    $Res Function(_$ProjectDtoImpl) then,
  ) = __$$ProjectDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    String title,
    String description,
    List<String> requirements,
    String startDate,
    String endDate,
    String deadline,
  });
}

/// @nodoc
class __$$ProjectDtoImplCopyWithImpl<$Res>
    extends _$ProjectDtoCopyWithImpl<$Res, _$ProjectDtoImpl>
    implements _$$ProjectDtoImplCopyWith<$Res> {
  __$$ProjectDtoImplCopyWithImpl(
    _$ProjectDtoImpl _value,
    $Res Function(_$ProjectDtoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ProjectDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? requirements = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? deadline = null,
  }) {
    return _then(
      _$ProjectDtoImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as int,
        title:
            null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                    as String,
        description:
            null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                    as String,
        requirements:
            null == requirements
                ? _value._requirements
                : requirements // ignore: cast_nullable_to_non_nullable
                    as List<String>,
        startDate:
            null == startDate
                ? _value.startDate
                : startDate // ignore: cast_nullable_to_non_nullable
                    as String,
        endDate:
            null == endDate
                ? _value.endDate
                : endDate // ignore: cast_nullable_to_non_nullable
                    as String,
        deadline:
            null == deadline
                ? _value.deadline
                : deadline // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ProjectDtoImpl implements _ProjectDto {
  const _$ProjectDtoImpl({
    required this.id,
    required this.title,
    required this.description,
    required final List<String> requirements,
    required this.startDate,
    required this.endDate,
    required this.deadline,
  }) : _requirements = requirements;

  factory _$ProjectDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProjectDtoImplFromJson(json);

  @override
  final int id;
  @override
  final String title;
  @override
  final String description;
  final List<String> _requirements;
  @override
  List<String> get requirements {
    if (_requirements is EqualUnmodifiableListView) return _requirements;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_requirements);
  }

  @override
  final String startDate;
  @override
  final String endDate;
  @override
  final String deadline;

  @override
  String toString() {
    return 'ProjectDto(id: $id, title: $title, description: $description, requirements: $requirements, startDate: $startDate, endDate: $endDate, deadline: $deadline)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProjectDtoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(
              other._requirements,
              _requirements,
            ) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.deadline, deadline) ||
                other.deadline == deadline));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    title,
    description,
    const DeepCollectionEquality().hash(_requirements),
    startDate,
    endDate,
    deadline,
  );

  /// Create a copy of ProjectDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProjectDtoImplCopyWith<_$ProjectDtoImpl> get copyWith =>
      __$$ProjectDtoImplCopyWithImpl<_$ProjectDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProjectDtoImplToJson(this);
  }
}

abstract class _ProjectDto implements ProjectDto {
  const factory _ProjectDto({
    required final int id,
    required final String title,
    required final String description,
    required final List<String> requirements,
    required final String startDate,
    required final String endDate,
    required final String deadline,
  }) = _$ProjectDtoImpl;

  factory _ProjectDto.fromJson(Map<String, dynamic> json) =
      _$ProjectDtoImpl.fromJson;

  @override
  int get id;
  @override
  String get title;
  @override
  String get description;
  @override
  List<String> get requirements;
  @override
  String get startDate;
  @override
  String get endDate;
  @override
  String get deadline;

  /// Create a copy of ProjectDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProjectDtoImplCopyWith<_$ProjectDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
