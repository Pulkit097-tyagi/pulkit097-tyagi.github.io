enum ExperienceType { work, education }

class Experience {
  final String title; // Role or Degree
  final String organization; // Company or School
  final String period; // e.g. "2023 - Present"
  final String description; // Summary of tasks/milestones
  final ExperienceType type;
  final List<String>? bulletPoints;

  const Experience({
    required this.title,
    required this.organization,
    required this.period,
    required this.description,
    required this.type,
    this.bulletPoints,
  });
}
