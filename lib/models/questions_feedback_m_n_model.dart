// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class QuestionsFeedbackMNModel {
  final String questionId;
  final String feedbackId;
  final double rating;
  final String comment;

  QuestionsFeedbackMNModel({
    required this.questionId,
    required this.feedbackId,
    required this.rating,
    required this.comment,
  });

  QuestionsFeedbackMNModel copyWith({
    String? questionId,
    String? feedbackId,
    double? rating,
    String? comment,
  }) {
    return QuestionsFeedbackMNModel(
      questionId: questionId ?? this.questionId,
      feedbackId: feedbackId ?? this.feedbackId,
      rating: rating ?? this.rating,
      comment: comment ?? this.comment,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'questionId': questionId,
      'feedbackId': feedbackId,
      'rating': rating,
      'comment': comment,
    };
  }

  factory QuestionsFeedbackMNModel.fromMap(Map<String, dynamic> map) {
    return QuestionsFeedbackMNModel(
      questionId: map['questionId'] as String,
      feedbackId: map['feedbackId'] as String,
      rating: map['rating'] as double,
      comment: map['comment'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory QuestionsFeedbackMNModel.fromJson(String source) =>
      QuestionsFeedbackMNModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'QuestionsFeedbackMNModel(questionId: $questionId, feedbackId: $feedbackId, rating: $rating, comment: $comment)';
  }

  @override
  bool operator ==(covariant QuestionsFeedbackMNModel other) {
    if (identical(this, other)) return true;

    return other.questionId == questionId &&
        other.feedbackId == feedbackId &&
        other.rating == rating &&
        other.comment == comment;
  }

  @override
  int get hashCode {
    return questionId.hashCode ^
        feedbackId.hashCode ^
        rating.hashCode ^
        comment.hashCode;
  }
}
