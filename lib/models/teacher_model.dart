class Teacher {
  final String id;
  final String name;
  final String email;
  final bool isPermanant;
  final List<String> subjects;
  final bool isTeaching;
  final double rating;

  Teacher({
    required this.id,
    required this.name,
    required this.email,
    required this.isPermanant,
    required this.subjects,
    required this.isTeaching,
    required this.rating,
  });
}
