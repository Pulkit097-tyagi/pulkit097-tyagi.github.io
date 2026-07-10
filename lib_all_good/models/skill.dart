
enum SkillCategory {
  languages('Languages'),
  frameworks('Frameworks & Libs'),
  cloud('Cloud & DevOps'),
  tools('Design & Tools');

  final String displayName;
  const SkillCategory(this.displayName);
}

class Skill {
  final String name;
  final double level; // 0.0 to 1.0 representing proficiency
  final SkillCategory category;
  final dynamic iconData;
  final String? fontPackage;
  final String? fontFamily;

  const Skill({
    required this.name,
    required this.level,
    required this.category,
    this.iconData,
    this.fontPackage,
    this.fontFamily,
  });
}
