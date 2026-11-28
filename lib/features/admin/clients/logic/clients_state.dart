import '../data/models/client_model.dart';

class ClientsState {
  final bool isLoading;
  final List<ClientModel> clients;
  final String? errorMessage;

  const ClientsState({
    this.isLoading = false,
    this.clients = const [],
    this.errorMessage,
  });

  ClientsState copyWith({
    bool? isLoading,
    List<ClientModel>? clients,
    String? errorMessage,
    bool clearError = false,
  }) {
    return ClientsState(
      isLoading: isLoading ?? this.isLoading,
      clients: clients ?? this.clients,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
    );
  }
}
