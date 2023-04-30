class User {
  final String id;
  final String email;
  final String password;
  final String sectionId;
  final String courseId;
  final bool isWorking;
  final bool isAdmin;

  User({
    required this.id,
    required this.email,
    required this.password,
    required this.sectionId,
    required this.courseId,
    required this.isWorking,
    required this.isAdmin,
  });
}
