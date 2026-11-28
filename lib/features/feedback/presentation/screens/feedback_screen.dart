import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../data/repos/feedback_repository.dart';

import '../../logic/feedback_cubit.dart';
import '../../logic/feedback_state.dart';
import '../widgets/completed_trip_card.dart';
import '../widgets/feedback_app_bar.dart';
import '../widgets/overall_experience_card.dart';
import '../widgets/experience_label.dart';
import '../widgets/feedback_text_field.dart';
import '../widgets/character_counter.dart';
import '../widgets/feedback_submit_button.dart';
import '../widgets/remind_later_button.dart';

class FeedbackScreen extends StatelessWidget {
  final String tripId;
  final String destinationName;
  final String imageUrl;
  final String tripDate;

  const FeedbackScreen({
    super.key,
    required this.tripId,
    required this.destinationName,
    required this.imageUrl,
    required this.tripDate,
  });

  @override
  Widget build(BuildContext context) {
    final supabase = Supabase.instance.client;

    return BlocProvider(
      create: (_) => FeedbackCubit(
        feedbackRepository: FeedbackRepository(supabase: supabase),
      ),
      child: FeedbackView(
        tripId: tripId,
        destinationName: destinationName,
        imageUrl: imageUrl,
        tripDate: tripDate,
      ),
    );
  }
}

class FeedbackView extends StatefulWidget {
  final String tripId;
  final String destinationName;
  final String imageUrl;
  final String tripDate;

  const FeedbackView({
    super.key,
    required this.tripId,
    required this.destinationName,
    required this.imageUrl,
    required this.tripDate,
  });

  @override
  State<FeedbackView> createState() => _FeedbackViewState();
}

class _FeedbackViewState extends State<FeedbackView> {
  static const Color backgroundColor = Color(0xFFFFF8F4);
  static const Color darkBrown = Color(0xFF302318);

  String? selectedExperience;

  final List<String> experienceLabels = [
    'Amazing',
    'Good',
    'Average',
    'Could be better',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: FeedbackAppBar(
        title: 'Your Feedback',
        onBack: () {
          Navigator.pop(context);
        },
      ),
      body: BlocConsumer<FeedbackCubit, FeedbackState>(
        listener: (context, state) {
          if (state.status == FeedbackStatus.success) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Your feedback was submitted successfully!'),
              ),
            );

            Navigator.pop(context);
          }

          if (state.status == FeedbackStatus.error &&
              state.errorMessage != null) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
          }
        },
        builder: (context, state) {
          final cubit = context.read<FeedbackCubit>();

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CompletedJourneyCard(
                  destinationName: widget.destinationName,
                  imageUrl: widget.imageUrl,
                  tripDate: widget.tripDate,
                ),

                const SizedBox(height: 24),

                OverallExperienceCard(
                  selectedRating: state.selectedRating,
                  onRatingSelected: cubit.selectRating,
                ),

                const SizedBox(height: 20),

                const Text(
                  'How was your experience?',
                  style: TextStyle(
                    color: darkBrown,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 12),

                Wrap(
                  spacing: 8,
                  runSpacing: 10,
                  children: experienceLabels.map((label) {
                    return ExperienceLabel(
                      label: label,
                      isSelected: selectedExperience == label,
                      onTap: () {
                        setState(() {
                          selectedExperience = label;
                        });
                      },
                    );
                  }).toList(),
                ),

                const SizedBox(height: 24),

                const Text(
                  'Your Thoughts',
                  style: TextStyle(
                    color: darkBrown,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 12),

                FeedbackTextField(
                  initialValue: state.comment,
                  onChanged: cubit.updateComment,
                ),

                const SizedBox(height: 8),

                CharacterCounter(currentLength: state.comment.length),

                const SizedBox(height: 24),

                FeedbackSubmitButton(
                  isLoading: state.status == FeedbackStatus.submitting,
                  onPressed: () {
                    final user = Supabase.instance.client.auth.currentUser;

                    if (user == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please log in first.')),
                      );
                      return;
                    }

                    final userName =
                        user.userMetadata?['full_name'] ??
                        user.email?.split('@').first ??
                        'Anonymous';

                    cubit.submitFeedback(
                      tripId: widget.tripId,
                      userId: user.id,
                      userName: userName.toString(),
                    );
                  },
                ),

                const SizedBox(height: 8),

                Center(
                  child: RemindLaterButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
