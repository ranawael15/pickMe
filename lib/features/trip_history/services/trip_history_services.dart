import 'package:supabase_flutter/supabase_flutter.dart';

class TripService {
  final supabase = Supabase.instance.client;

  Future<List<Map<String, dynamic>>> getAllTrips() async {
    try {
      final response = await supabase
          .from('trips')
          .select();

      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      throw Exception('Failed to fetch trips: $e');
    }
  }

  Future<void> updateTrip({required String id}) async {
    try {
      await supabase
          .from('trips')
          .update({
        'status': 'Completed',
        'completed_at': DateTime.now().toUtc().toIso8601String(),
      })
          .eq('id', id);

    } catch (e) {
      rethrow;
    }
  }


  Future<List<Map<String, dynamic>>> getTripDetails(
      String tripId) async {
    try {
      final response = await supabase
          .from('trip_places')
          .select()
          .eq('trip_id', tripId);

      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      throw Exception('Failed to fetch trips: $e');
    }
  }

}