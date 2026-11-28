import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/models/feedback_model.dart';
import '../data/repos/feedback_repository.dart';
import 'feedback_state.dart';

class FeedbackCubit extends Cubit<FeedbackState> {
  final FeedbackRepository feedbackRepository;

  FeedbackCubit({required this.feedbackRepository})
    : super(const FeedbackState());

  // Select rating stars.
  void selectRating(int rating) {
    if (rating < 1 || rating > 5) return;

    emit(state.copyWith(selectedRating: rating, clearError: true));
  }

  // Update feedback comment.
  void updateComment(String comment) {
    emit(state.copyWith(comment: comment, clearError: true));
  }

  // Load all feedbacks.
  Future<void> loadFeedbacks() async {
    emit(state.copyWith(status: FeedbackStatus.loading, clearError: true));

    try {
      final feedbacks = await feedbackRepository.getFeedbacks();

      emit(state.copyWith(status: FeedbackStatus.loaded, feedbacks: feedbacks));
    } catch (e) {
      emit(
        state.copyWith(
          status: FeedbackStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  // Submit a new feedback.
  Future<void> submitFeedback({
    required String tripId,
    required String userId,
    required String userName,
  }) async {
    if (state.status == FeedbackStatus.submitting) return;

    if (tripId.trim().isEmpty || userId.trim().isEmpty) {
      emit(
        state.copyWith(
          status: FeedbackStatus.error,
          errorMessage: 'Trip or user information is missing.',
        ),
      );
      return;
    }

    if (state.selectedRating == 0) {
      emit(
        state.copyWith(
          status: FeedbackStatus.error,
          errorMessage: 'Please select a rating first.',
        ),
      );
      return;
    }

    if (state.comment.trim().isEmpty) {
      emit(
        state.copyWith(
          status: FeedbackStatus.error,
          errorMessage: 'Please write your feedback.',
        ),
      );
      return;
    }

    emit(state.copyWith(status: FeedbackStatus.submitting, clearError: true));

    try {
      final feedback = FeedbackModel(
        tripId: tripId,
        userId: userId,
        userName: userName,
        rating: state.selectedRating,
        comment: state.comment.trim(),
        createdAt: DateTime.now(),
      );

      await feedbackRepository.submitFeedback(feedback);

      final feedbacks = await feedbackRepository.getFeedbacks();

      emit(
        state.copyWith(
          status: FeedbackStatus.success,
          feedbacks: feedbacks,
          selectedRating: 0,
          comment: '',
          clearError: true,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: FeedbackStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  // Reset feedback form.
  void resetForm() {
    emit(
      state.copyWith(
        status: FeedbackStatus.initial,
        selectedRating: 0,
        comment: '',
        clearError: true,
      ),
    );
  }
}
