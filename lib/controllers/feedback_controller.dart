import 'package:feedbacksystem/apis/feedback_api.dart';
import 'package:feedbacksystem/apis/teachers_api.dart';
import 'package:feedbacksystem/helper/enums/question_type.dart';
import 'package:feedbacksystem/models/feedback_home_data_model.dart';
import 'package:feedbacksystem/models/indexd_feedbacks.dart';
import 'package:feedbacksystem/models/question_model.dart';
import 'package:feedbacksystem/models/subject_model.dart';
import 'package:feedbacksystem/models/teacher_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../helper/shared_state/updator.dart';
import '../models/user_teacher_feedback_mxn_model.dart';

final feedbackControllerProvider =
    StateNotifierProvider<FeedbackController, AsyncValue>((ref) {
  return FeedbackController(
    feedbackApi: ref.watch(feedBackApiProvider),
    teacherApi: ref.watch(teacherApiProvider),
  );
});

final feedbackSubjectsProvider =
    FutureProvider.family.autoDispose((ref, String userId) {
  final feedbackController = ref.watch(feedbackControllerProvider.notifier);
  ref.watch(futureStateUpdator);

  return feedbackController.getPendingFeedbacksData(userId);
});

final feedbackQuestionProvider = FutureProvider.autoDispose((ref) {
  final feedbackController = ref.watch(feedbackControllerProvider.notifier);

  return feedbackController.getQuestions();
});

class FeedbackController extends StateNotifier<AsyncValue> {
  final FeedBackApi _feedbackApi;
  final TeacherApi _teacherApi;

  FeedbackController(
      {required FeedBackApi feedbackApi, required TeacherApi teacherApi})
      : _feedbackApi = feedbackApi,
        _teacherApi = teacherApi,
        super(
          const AsyncData(null),
        );

  Future<List<FeedbackHomeDataModel>> getPendingFeedbacksData(
      String userId) async {
    final List<FeedbackHomeDataModel> result = [];
    final List<UserTeacherFeedbackMxN> pendingfeedbacks =
        await getPendingFeedbacks(userId);
    if (pendingfeedbacks.isNotEmpty) {
      final res = await _feedbackApi.getPendingFeedbackSubjectsData(
          pendingfeedbacks.map((e) => e.subjectId).toList());

      final teachers = await getTeacherByIds(pendingfeedbacks);

      for (int i = 0; i < res.length; i++) {
        final subjectModel = SubjectModel.fromMap(res[i].data);
        result.add(
          FeedbackHomeDataModel(
            subjectModel: subjectModel,
            teacher: teachers
                .firstWhere((e) => e.id == pendingfeedbacks[i].teacherId),
            userTeacherFeedbackMxN: pendingfeedbacks.firstWhere(
              (e) => e.subjectId == subjectModel.id,
            ),
          ),
        );
      }
    }
    return result;
  }

  Future<List<UserTeacherFeedbackMxN>> getPendingFeedbacks(
      String userId) async {
    final res = await _feedbackApi.getPendingFeedbacks(userId);

    final List<UserTeacherFeedbackMxN> result = [];
    for (var element in res) {
      result.add(UserTeacherFeedbackMxN.fromMap(element.data));
    }
    return result;
  }

  Future<List<Teacher>> getTeacherByIds(
      List<UserTeacherFeedbackMxN> userTeacherList) async {
    final List<Teacher> teacherDataList = [];
    for (var item in userTeacherList) {
      final res = await _teacherApi.getTeacherById(item.teacherId);

      res.fold((l) => l.message, (r) {
        teacherDataList.add(Teacher.fromMap(r));
      });
    }

    return teacherDataList;
  }

  Future<List<QuestionModel>> getQuestions() async {
    final res = await _feedbackApi.getQuestions();

    final List<QuestionModel> result = [];
    for (var element in res) {
      result.add(QuestionModel.fromMap(element.data));
    }
    return result;
  }

  Future<bool> submitFeedback(List<IndexdFeedBacks> feedbacks,
      int questionsLength, UserTeacherFeedbackMxN data) async {
    state = const AsyncData(null);
    state = const AsyncValue.loading();
    bool hasError = false;

    if (questionsLength != feedbacks.length) {
      state =
          AsyncValue.error("Please fill all the questions", StackTrace.current);
      return false;
    }

    for (var item in feedbacks) {
      if (item.questionType == QuestionType.rating) {
        if (item.feedback.rating == 0) {
          hasError = true;
          state = AsyncValue.error(
              "Please fill all the questions", StackTrace.current);
          return false;
        }
      } else if (item.questionType == QuestionType.comment) {
        if (item.feedback.comment.isEmpty) {
          hasError = true;
          state = AsyncValue.error(
              "Please fill all the questions", StackTrace.current);
          return false;
        }
      }
    }

    if (hasError != true) {
      final res = await _feedbackApi.submitFeedback(
        feedbacks.map((e) => e.feedback).toList(),
        data,
      );
      res.fold(
        (l) => state = AsyncValue.error(l, StackTrace.current),
        (r) => state = AsyncValue.data(r),
      );
    }
    return state.hasError == false;
  }

  // Future<void> updateTeacherRating(List<IndexdFeedBacks> feedbacks) async {
  //   double totalRating = 0;
  //   double totalratingQuestions = 0;

  //   for(var feedback in feedbacks){

  //     if(feedback.questionType  == QuestionType.rating){
  //       totalRating += feedback.feedback.rating;
  //       totalratingQuestions++;
  //     }
  //   }

  //   await _teacherApi.updateTeacherData(
  //     Teacher(
  //       rating: totalRating / totalratingQuestions,
  //     ),
  //   );

  // }
}
