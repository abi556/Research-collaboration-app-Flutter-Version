import 'package:freezed_annotation/freezed_annotation.dart';

part 'application.freezed.dart';
part 'application.g.dart';

enum ApplicationStatus {
  PENDING,
  APPROVED,
  REJECTED,
}

@freezed
class Application with _$Application {
  const factory Application({
    required int id,
    required int studentId,
    required int projectId,
    required ApplicationStatus status,
  }) = _Application;

  factory Application.fromJson(Map<String, dynamic> json) => _$ApplicationFromJson(json);
} 