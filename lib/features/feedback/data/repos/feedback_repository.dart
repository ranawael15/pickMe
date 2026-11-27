
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/feedback_model.dart';

class FeedbackRepository {
  final SupabaseClient supabase;

  FeedbackRepository({
    required this.supabase,
  });

  // Submit a new feedback to Supabase.
  Future<void> submitFeedback(FeedbackModel feedback) async {
    await supabase
        .from('feedbacks')
        .insert(feedback.toMap());
  }

  // Get all feedbacks from Supabase.
  Future<List<FeedbackModel>> getFeedbacks() async {
    final response = await supabase
        .from('feedbacks')
        .select()
        .order('created_at', ascending: false);

    return response
        .map<FeedbackModel>(
          (item) => FeedbackModel.fromMap(item),
    )
        .toList();
  }
}
