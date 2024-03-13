// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:feedbacksystem/models/subject_model.dart';
import 'package:feedbacksystem/models/user_teacher_feedback_mxn_model.dart';

import 'teacher_model.dart';

class FeedbackHomeDataModel {
  final SubjectModel subjectModel;
  final Teacher teacher;
  final UserTeacherFeedbackMxN userTeacherFeedbackMxN;

  FeedbackHomeDataModel({
    required this.subjectModel,
    required this.teacher,
    required this.userTeacherFeedbackMxN,
  });

  FeedbackHomeDataModel copyWith({
    SubjectModel? subjectModel,
    Teacher? teacher,
    UserTeacherFeedbackMxN? userTeacherFeedbackMxN,
  }) {
    return FeedbackHomeDataModel(
      subjectModel: subjectModel ?? this.subjectModel,
      teacher: teacher ?? this.teacher,
      userTeacherFeedbackMxN:
          userTeacherFeedbackMxN ?? this.userTeacherFeedbackMxN,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'subjectModel': subjectModel.toMap(),
      'teacher': teacher.toMap(),
      'userTeacherFeedbackMxN': userTeacherFeedbackMxN.toMap(),
    };
  }

  factory FeedbackHomeDataModel.fromMap(Map<String, dynamic> map) {
    return FeedbackHomeDataModel(
      subjectModel:
          SubjectModel.fromMap(map['subjectModel'] as Map<String, dynamic>),
      teacher: Teacher.fromMap(map['teacher'] as Map<String, dynamic>),
      userTeacherFeedbackMxN: UserTeacherFeedbackMxN.fromMap(
          map['userTeacherFeedbackMxN'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory FeedbackHomeDataModel.fromJson(String source) =>
      FeedbackHomeDataModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'FeedbackHomeDataModel(subjectModel: $subjectModel, teacher: $teacher, userTeacherFeedbackMxN: $userTeacherFeedbackMxN)';

  @override
  bool operator ==(covariant FeedbackHomeDataModel other) {
    if (identical(this, other)) return true;

    return other.subjectModel == subjectModel &&
        other.teacher == teacher &&
        other.userTeacherFeedbackMxN == userTeacherFeedbackMxN;
  }

  @override
  int get hashCode =>
      subjectModel.hashCode ^
      teacher.hashCode ^
      userTeacherFeedbackMxN.hashCode;
}
