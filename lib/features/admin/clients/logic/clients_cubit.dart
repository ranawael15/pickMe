
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/models/client_model.dart';
import '../data/repos/clients_repo.dart';
import 'clients_state.dart';

class ClientsCubit extends Cubit<ClientsState> {
  final ClientsRepo clientsRepo;

  ClientsCubit({
    required this.clientsRepo,
  }) : super(const ClientsState());

  // Load all clients.
  Future<void> getClients() async {
    emit(state.copyWith(
      isLoading: true,
      clearError: true,
    ));

    try {
      final clients = await clientsRepo.getClients();

      emit(state.copyWith(
        isLoading: false,
        clients: clients,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      ));
    }
  }

  // Update client information.
  Future<void> updateClient({
    required String clientId,
    required String fullName,
    required String email,
    required String phone,
  }) async {
    await clientsRepo.updateClient(
      clientId: clientId,
      fullName: fullName,
      email: email,
      phone: phone,
    );

    await getClients();
  }

  // Delete client account.
  Future<void> deleteClient({
    required String clientId,
  }) async {
    try {
      await clientsRepo.deleteClient(clientId);

      final updatedClients = state.clients
          .where((client) => client.id != clientId)
          .toList();

      emit(state.copyWith(
        clients: updatedClients,
        clearError: true,
      ));
    } catch (e) {
      emit(state.copyWith(
        errorMessage: e.toString(),
      ));

      rethrow;
    }
  }

  // Search clients.
  List<ClientModel> searchClients(String query) {
    if (query.trim().isEmpty) {
      return state.clients;
    }

    final searchQuery = query.toLowerCase().trim();

    return state.clients.where((client) {
      return client.fullName.toLowerCase().contains(searchQuery) ||
          client.email.toLowerCase().contains(searchQuery);
    }).toList();
  }

  // Refresh clients.
  Future<void> refreshClients() async {
    await getClients();
  }
}
