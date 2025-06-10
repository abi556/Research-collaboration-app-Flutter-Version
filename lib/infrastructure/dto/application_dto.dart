import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/application.dart';

part 'application_dto.freezed.dart';
part 'application_dto.g.dart';

@freezed
class ApplicationDto with _$ApplicationDto {
  const factory ApplicationDto({
    required int id,
    required int studentId,
    required int projectId,
    required ApplicationStatus status,
  }) = _ApplicationDto;

  factory ApplicationDto.fromJson(Map<String, dynamic> json) => _$ApplicationDtoFromJson(json);
}

extension ApplicationDtoX on ApplicationDto {
  Application toDomain() => Application(
    id: id,
    studentId: studentId,
    projectId: projectId,
    status: status,
  );

  static ApplicationDto fromDomain(Application application) => ApplicationDto(
    id: application.id,
    studentId: application.studentId,
    projectId: application.projectId,
    status: application.status,
  );
} 