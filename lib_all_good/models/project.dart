class Project {
  final String title;
  final String imagePath;
  final String description;
  final List<String> tags;
  final String? githubUrl;
  final String? androidUrl;
  final String? iosUrl;
  final bool isFeatured;
  final String imageUrl;

  const Project({
    required this.title,
    required this.imagePath,
    required this.description,
    required this.tags,
    this.githubUrl,
    this.androidUrl,
    this.iosUrl,
    this.isFeatured = false,
    required this.imageUrl,
  });
}
