import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/user.dart';

part 'user_dto.freezed.dart';
part 'user_dto.g.dart';

@freezed
class UserDto with _$UserDto {
  const factory UserDto({
    required int id,
    required String email,
    String? name,
    String? department,
    String? bio,
    Role? role,
    List<String>? skills,
    String? researchInterests,
    bool? isActive,
  }) = _UserDto;

  factory UserDto.fromJson(Map<String, dynamic> json) => _$UserDtoFromJson(json);
}

extension UserDtoX on UserDto {
  User toDomain() => User(
    id: id,
    email: email,
    name: name,
    department: department,
    bio: bio,
    role: role,
    skills: skills,
    researchInterests: researchInterests,
    isActive: isActive,
  );

  static UserDto fromDomain(User user) => UserDto(
    id: user.id,
    email: user.email,
    name: user.name,
    department: user.department,
    bio: user.bio,
    role: user.role,
    skills: user.skills,
    researchInterests: user.researchInterests,
    isActive: user.isActive,
  );
} 