import 'destinations_cubit.dart';

class DestinationsState {
  final List<Destination> destinations;
  final String searchQuery;

  const DestinationsState({
    this.destinations = const [],
    this.searchQuery = '',
  });

  List<Destination> get filteredDestinations {
    if (searchQuery.trim().isEmpty) {
      return destinations;
    }

    return destinations.where((destination) {
      return destination.name.toLowerCase().contains(
            searchQuery.toLowerCase(),
          ) ||
          destination.region.toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();
  }

  DestinationsState copyWith({
    List<Destination>? destinations,
    String? searchQuery,
  }) {
    return DestinationsState(
      destinations: destinations ?? this.destinations,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}
