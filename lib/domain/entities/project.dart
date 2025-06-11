import 'package:freezed_annotation/freezed_annotation.dart';

part 'project.freezed.dart';
part 'project.g.dart';

@freezed
class Project with _$Project {
  const factory Project({
    int? id,
    required String title,
    required String description,
    required List<String> requirements,
    required String startDate,
    required String endDate,
    required String deadline,
    required int professorId,
  }) = _Project;

  factory Project.fromJson(Map<String, dynamic> json) => _$ProjectFromJson(json);
} 