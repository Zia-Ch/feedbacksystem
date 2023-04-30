class Feedback {
  final String id;
  final String courseId;
  final String subjectId;
  final String semesterId;
  final String teacherId;
  final String sectionId;
  final double rating;
  final String comment;

  Feedback({
    required this.id,
    required this.courseId,
    required this.subjectId,
    required this.semesterId,
    required this.teacherId,
    required this.sectionId,
    required this.rating,
    required this.comment,
  });
}
