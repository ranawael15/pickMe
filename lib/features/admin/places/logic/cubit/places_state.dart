import 'places_cubit.dart';

class PlacesState {
  final List<Place> places;

  const PlacesState({this.places = const []});

  List<Place> placesForDestination(String destinationId) {
    return places
        .where((place) => place.destinationId == destinationId)
        .toList();
  }

  PlacesState copyWith({List<Place>? places}) {
    return PlacesState(places: places ?? this.places);
  }
}
