import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/project.dart';

part 'project_dto.freezed.dart';
part 'project_dto.g.dart';

@freezed
class ProjectDto with _$ProjectDto {
  const factory ProjectDto({
    int? id,
    required String title,
    required String description,
    required List<String> requirements,
    required String startDate,
    required String endDate,
    required String deadline,
  }) = _ProjectDto;

  factory ProjectDto.fromJson(Map<String, dynamic> json) => _$ProjectDtoFromJson(json);
}

extension ProjectDtoX on ProjectDto {
  Project toDomain() => Project(
    id: id,
    title: title,
    description: description,
    requirements: requirements,
    startDate: startDate,
    endDate: endDate,
    deadline: deadline,
  );

  static ProjectDto fromDomain(Project project) => ProjectDto(
    id: project.id,
    title: project.title,
    description: project.description,
    requirements: project.requirements,
    startDate: project.startDate,
    endDate: project.endDate,
    deadline: project.deadline,
  );
} 