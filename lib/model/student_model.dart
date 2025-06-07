class StudentProfile {
  final int id;
  final String name;
  final String department;
  final String email;
  final String college;
  final String year;
  final List<String> skill;
  final String description;

  StudentProfile({
    required this.id,
    required this.name,
    required this.department,
    required this.email,
    required this.college,
    required this.year,
    required this.skill,
    required this.description,
  });

  factory StudentProfile.fromJson(Map<String, dynamic> json) {
    return StudentProfile(
      id: json['id'],
      name: json['name'],
      department: json['department'],
      email: json['email'],
      college: json['college'],
      year: json['year'],
      skill: List<String>.from(json['skill']),
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'department': department,
      'email': email,
      'college': college,
      'year': year,
      'skill': skill,
      'description': description,
    };
  }
}
