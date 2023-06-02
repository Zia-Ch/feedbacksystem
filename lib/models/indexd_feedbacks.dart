import 'package:feedbacksystem/helper/enums/question_type.dart';
import 'package:feedbacksystem/models/feedback_model.dart';

class IndexdFeedBacks {
  final FeedbackModel feedback;
  final int index;
  final QuestionType questionType;
  const IndexdFeedBacks({
    required this.feedback,
    required this.index,
    required this.questionType,
  });
}
