// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class SubjectModel {
  final String id;
  final String subjectName;
  final String subjectCode;
  final String courseId;
  final String semesterId;

  SubjectModel({
    required this.id,
    required this.subjectName,
    required this.subjectCode,
    required this.courseId,
    required this.semesterId,
  });

  SubjectModel copyWith({
    String? id,
    String? subjectName,
    String? subjectCode,
    String? courseId,
    String? semesterId,
  }) {
    return SubjectModel(
      id: id ?? this.id,
      subjectName: subjectName ?? this.subjectName,
      subjectCode: subjectCode ?? this.subjectCode,
      courseId: courseId ?? this.courseId,
      semesterId: semesterId ?? this.semesterId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '\$id': id,
      'subjectName': subjectName,
      'subjectCode': subjectCode,
      'courseId': courseId,
      'semesterId': semesterId,
    };
  }

  factory SubjectModel.fromMap(Map<String, dynamic> map) {
    return SubjectModel(
      id: map['\$id'] as String,
      subjectName: map['subjectName'] as String,
      subjectCode: map['subjectCode'] as String,
      courseId: map['courseId'] as String,
      semesterId: map['semesterId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SubjectModel.fromJson(String source) =>
      SubjectModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SubjectModel(id: $id, subjectName: $subjectName, subjectCode: $subjectCode, courseId: $courseId, semesterId: $semesterId)';
  }

  @override
  bool operator ==(covariant SubjectModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.subjectName == subjectName &&
        other.subjectCode == subjectCode &&
        other.courseId == courseId &&
        other.semesterId == semesterId;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        subjectName.hashCode ^
        subjectCode.hashCode ^
        courseId.hashCode ^
        semesterId.hashCode;
  }
}
