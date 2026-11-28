import 'package:flutter_bloc/flutter_bloc.dart';
import 'destinations_state.dart';

class Destination {
  final String id;
  final String name;
  final String description;
  final String image;
  final String region;
  final List<String> categories;

  const Destination({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.region,
    this.categories = const [],
  });

  Destination copyWith({
    String? name,
    String? description,
    String? image,
    String? region,
    List<String>? categories,
  }) {
    return Destination(
      id: id,
      name: name ?? this.name,
      description: description ?? this.description,
      image: image ?? this.image,
      region: region ?? this.region,
      categories: categories ?? this.categories,
    );
  }
}

class DestinationsCubit extends Cubit<DestinationsState> {
  DestinationsCubit() : super(const DestinationsState()) {
    loadInitialDestinations();
  }

  void loadInitialDestinations() {
    emit(
      state.copyWith(
        destinations: const [
          Destination(
            id: 'CAI-01',
            name: 'Cairo',
            region: 'Greater Cairo',
            image: 'assets/images/cairo.png',
            description:
                'The historic capital of Egypt featuring the Giza Plateau, Nile cruises, and Islamic Cairo.',
            categories: [
              'Historical & Ancient',
              'Museums & Culture',
              'Shopping & Cultural',
              'Scenic Views & Parks',
              'Food & Dining',
            ],
          ),
          Destination(
            id: 'ALEX-01',
            name: 'Alexandria',
            region: 'North Coast',
            image: 'assets/images/alex.png',
            description:
                'The pearl of the Mediterranean with historic citadels, coastal dining, and the ancient library.',
            categories: [
              'Beaches',
              'Historical & Ancient',
              'Food & Dining',
              'Scenic Views & Parks',
            ],
          ),
          Destination(
            id: 'SH-01',
            name: 'Sharm El Sheikh',
            region: 'South Sinai',
            image: 'assets/images/sharm.png',
            description:
                'Red Sea luxury resort destination famed for world-class diving, beaches, and desert safaris.',
            categories: ['Beaches', 'Adventure', 'Water Activities'],
          ),
        ],
      ),
    );
  }

  void searchDestinations(String query) {
    emit(state.copyWith(searchQuery: query));
  }

  void addDestination(Destination destination) {
    final updated = [...state.destinations, destination];

    emit(state.copyWith(destinations: updated));
  }

  void updateDestination(Destination updatedDestination) {
    final updated = state.destinations.map((destination) {
      return destination.id == updatedDestination.id
          ? updatedDestination
          : destination;
    }).toList();

    emit(state.copyWith(destinations: updated));
  }

  void deleteDestination(String id) {
    final updated = state.destinations
        .where((destination) => destination.id != id)
        .toList();

    emit(state.copyWith(destinations: updated));
  }

  Destination? getDestination(String id) {
    try {
      return state.destinations.firstWhere(
        (destination) => destination.id == id,
      );
    } catch (_) {
      return null;
    }
  }

  String generateId() {
    return 'DST-${DateTime.now().millisecondsSinceEpoch}';
  }
}
