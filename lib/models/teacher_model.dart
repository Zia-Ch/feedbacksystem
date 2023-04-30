class Teacher {
  final String id;
  final String name;
  final String email;
  final bool isPermanent;
  final List<String> subjectIds;
  final bool teachingCurrently;
  final double rating;

  Teacher({
    required this.id,
    required this.name,
    required this.email,
    required this.isPermanent,
    required this.subjectIds,
    required this.teachingCurrently,
    required this.rating,
  });
}
