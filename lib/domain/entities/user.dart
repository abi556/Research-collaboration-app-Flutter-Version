import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

enum Role {
  ADMIN,
  PROFESSOR,
  STUDENT,
}

@freezed
class User with _$User {
  const factory User({
    required int id,
    required String email,
    String? name,
    String? department,
    String? bio,
    Role? role,
    List<String>? skills,
    String? researchInterests,
    bool? isActive,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
} 