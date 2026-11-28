import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../data/repos/feedback_repository.dart';
import '../../logic/feedback_cubit.dart';
import '../../logic/feedback_state.dart';
import '../widgets/feedback_app_bar.dart';
import '../widgets/community_reviews_header.dart';
import '../widgets/community_review_card.dart';
import '../widgets/leave_feedback_card.dart';
import '../widgets/feedback_footer.dart';

class UsersFeedbackScreen extends StatelessWidget {
  final VoidCallback onLeaveFeedback;

  const UsersFeedbackScreen({super.key, required this.onLeaveFeedback});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FeedbackCubit(
        feedbackRepository: FeedbackRepository(
          supabase: Supabase.instance.client,
        ),
      )..loadFeedbacks(),
      child: UsersFeedbackView(onLeaveFeedback: onLeaveFeedback),
    );
  }
}

class UsersFeedbackView extends StatelessWidget {
  final VoidCallback onLeaveFeedback;

  const UsersFeedbackView({super.key, required this.onLeaveFeedback});

  static const Color backgroundColor = Color(0xFFFFF8F4);

  String getTimeAgo(DateTime date) {
    final difference = DateTime.now().difference(date);

    if (difference.inMinutes < 1) {
      return 'Just now';
    }

    if (difference.inHours < 1) {
      return '${difference.inMinutes} minutes ago';
    }

    if (difference.inDays < 1) {
      return '${difference.inHours} hours ago';
    }

    if (difference.inDays == 1) {
      return 'Yesterday';
    }

    if (difference.inDays < 30) {
      return '${difference.inDays} days ago';
    }

    if (difference.inDays < 365) {
      return '${(difference.inDays / 30).floor()} months ago';
    }

    return '${(difference.inDays / 365).floor()} years ago';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: FeedbackAppBar(
        title: 'Users Feedback',
        onBack: () {
          Navigator.pop(context);
        },
      ),
      body: BlocBuilder<FeedbackCubit, FeedbackState>(
        builder: (context, state) {
          if (state.status == FeedbackStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.status == FeedbackStatus.error) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 40,
                      color: Colors.red,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      state.errorMessage ?? 'Something went wrong.',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () {
                        context.read<FeedbackCubit>().loadFeedbacks();
                      },
                      child: const Text('Try Again'),
                    ),
                  ],
                ),
              ),
            );
          }

          final feedbacks = state.feedbacks;

          final averageRating = feedbacks.isEmpty
              ? 0.0
              : feedbacks.fold<int>(
                      0,
                      (sum, feedback) => sum + feedback.rating,
                    ) /
                    feedbacks.length;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommunityReviewsHeader(
                  averageRating: averageRating,
                  totalReviews: feedbacks.length,
                ),

                const SizedBox(height: 20),

                if (feedbacks.isEmpty)
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 30),
                      child: Column(
                        children: [
                          Icon(
                            Icons.rate_review_outlined,
                            size: 45,
                            color: Color(0xFF685744),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'No reviews yet.',
                            style: TextStyle(
                              color: Color(0xFF685744),
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            'Be the first to share your experience!',
                            style: TextStyle(
                              color: Color(0xFF685744),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                else
                  ...feedbacks.map(
                    (feedback) => CommunityReviewCard(
                      userName: feedback.userName,
                      timeAgo: getTimeAgo(feedback.createdAt),
                      rating: feedback.rating,
                      comment: feedback.comment,
                    ),
                  ),

                const SizedBox(height: 12),

                LeaveFeedbackCard(onPressed: onLeaveFeedback),

                const SizedBox(height: 12),

                const FeedbackFooter(),
              ],
            ),
          );
        },
      ),
    );
  }
}
