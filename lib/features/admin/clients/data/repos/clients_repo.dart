
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/client_model.dart';
import '../models/client_trip_model.dart';

class ClientsRepo {
  final SupabaseClient supabase;

  ClientsRepo(this.supabase);

  // Get all clients.
  Future<List<ClientModel>> getClients() async {
    final response = await supabase
        .from('profiles')
        .select()
        .eq('role', 'client')
        .order('created_at', ascending: false);

    return (response as List)
        .map((client) => ClientModel.fromJson(client))
        .toList();
  }

  // Get one client's trips.
  Future<List<ClientTripModel>> getClientTrips(String clientId) async {
    final response = await supabase
        .from('trips')
        .select('''
          id,
          user_id,
          destination_id,
          budget,
          status,
          trip_date,
          created_at,
          destinations (
            name
          )
        ''')
        .eq('user_id', clientId)
        .order('created_at', ascending: false);

    return (response as List).map((trip) {
      final destination = trip['destinations'];

      return ClientTripModel.fromJson({
        ...trip,
        'destination_name': destination?['name'] ?? 'Unknown destination',
      });
    }).toList();
  }

  // Update client information.
  Future<void> updateClient({
    required String clientId,
    required String fullName,
    required String email,
    required String phone,
  }) async {
    await supabase
        .from('profiles')
        .update({
      'full_name': fullName,
      'email': email,
      'phone': phone,
    })
        .eq('id', clientId);
  }

  // Delete client account using Supabase Edge Function.
  Future<void> deleteClient(String clientId) async {
    final response = await supabase.functions.invoke(
      'delete-client',
      body: {
        'clientId': clientId,
      },
    );

    if (response.status < 200 || response.status >= 300) {
      throw Exception('Failed to delete client account.');
    }
  }
}
