class SkinReport {
  final String title;
  final String category;
  final String description;
  final DateTime createdAt;

  const SkinReport({
    required this.title,
    required this.category,
    required this.description,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'category': category,
      'description': description,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}