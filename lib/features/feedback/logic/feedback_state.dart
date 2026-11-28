import '../data/models/feedback_model.dart';

enum FeedbackStatus { initial, loading, loaded, submitting, success, error }

class FeedbackState {
  final FeedbackStatus status;
  final List<FeedbackModel> feedbacks;
  final int selectedRating;
  final String comment;
  final String? errorMessage;

  const FeedbackState({
    this.status = FeedbackStatus.initial,
    this.feedbacks = const [],
    this.selectedRating = 0,
    this.comment = '',
    this.errorMessage,
  });

  FeedbackState copyWith({
    FeedbackStatus? status,
    List<FeedbackModel>? feedbacks,
    int? selectedRating,
    String? comment,
    String? errorMessage,
    bool clearError = false,
  }) {
    return FeedbackState(
      status: status ?? this.status,
      feedbacks: feedbacks ?? this.feedbacks,
      selectedRating: selectedRating ?? this.selectedRating,
      comment: comment ?? this.comment,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
    );
  }
}
