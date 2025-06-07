class Project {
  final int id;
  final String title;
  final String description;
  final List<String> requirements;
  final String startDate;
  final String endDate;
  final String deadline;

  Project({
    required this.id,
    required this.title,
    required this.description,
    required this.requirements,
    required this.startDate,
    required this.endDate,
    required this.deadline,
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      requirements: List<String>.from(json['requirements']),
      startDate: json['startDate'],
      endDate: json['endDate'],
      deadline: json['deadline'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'requirements': requirements,
      'startDate': startDate,
      'endDate': endDate,
      'deadline': deadline,
    };
  }
}
