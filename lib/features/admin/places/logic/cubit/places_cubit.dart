import 'package:flutter_bloc/flutter_bloc.dart';
import 'places_state.dart';
class Place {
  final String id;
  final String destinationId;
  final String name;
  final String description;
  final String image;
  final String category;
  final double price;
  final String currency;
  final bool freeEntry;
  final bool visible;
  final String opensAt;
  final String closesAt;
  final String budgetTier;
  final String locationHint;

  const Place({
    required this.id,
    required this.destinationId,
    required this.name,
    required this.description,
    required this.image,
    required this.category,
    required this.price,
    this.currency = 'EGP',
    this.freeEntry = false,
    this.visible = true,
    this.opensAt = '09:00 AM',
    this.closesAt = '05:00 PM',
    this.budgetTier = 'Budget (\$)',
    this.locationHint = '',
  });

  Place copyWith({
    String? name,
    String? description,
    String? image,
    String? category,
    double? price,
    String? currency,
    bool? freeEntry,
    bool? visible,
    String? opensAt,
    String? closesAt,
    String? budgetTier,
    String? locationHint,
  }) {
    return Place(
      id: id,
      destinationId: destinationId,
      name: name ?? this.name,
      description: description ?? this.description,
      image: image ?? this.image,
      category: category ?? this.category,
      price: price ?? this.price,
      currency: currency ?? this.currency,
      freeEntry: freeEntry ?? this.freeEntry,
      visible: visible ?? this.visible,
      opensAt: opensAt ?? this.opensAt,
      closesAt: closesAt ?? this.closesAt,
      budgetTier: budgetTier ?? this.budgetTier,
      locationHint: locationHint ?? this.locationHint,
    );
  }
}

class PlacesCubit extends Cubit<PlacesState> {
  PlacesCubit() : super(const PlacesState()) {
    loadInitialPlaces();
  }

  void loadInitialPlaces() {
    emit(
      state.copyWith(
        places: const [
          Place(
            id: 'CAI-01',
            destinationId: 'CAI-01',
            name: 'Giza Pyramids & Sphinx Complex',
            description:
            'The iconic plateau featuring Khufu, Khafre, and Menkaure alongside the Great Sphinx. Insider tip: visit early morning.',
            image: 'assets/images/cairo.png',
            category: 'Historical & Ancient',
            price: 540,
            opensAt: '08:00 AM',
            closesAt: '04:30 PM',
            budgetTier: 'Moderate (\$\$)',
          ),
          Place(
            id: 'CAI-02',
            destinationId: 'CAI-01',
            name: 'The Grand Egyptian Museum (GEM)',
            description:
            'State-of-the-art museum housing the complete Tutankhamun collection. Pre-booking is recommended.',
            image: 'assets/images/cairo.png',
            category: 'Museums & Culture',
            price: 1200,
            opensAt: '09:00 AM',
            closesAt: '06:00 PM',
            budgetTier: 'Luxury / VIP (\$\$\$)',
          ),
          Place(
            id: 'CAI-03',
            destinationId: 'CAI-01',
            name: 'Khan el-Khalili & El-Fishawy',
            description:
            'Historic 14th-century labyrinthine market filled with spices, brass lanterns, and jewelry.',
            image: 'assets/images/cairo.png',
            category: 'Shopping & Cultural',
            price: 0,
            freeEntry: true,
            opensAt: '10:00 AM',
            closesAt: '12:00 AM',
            budgetTier: 'Budget (\$)',
          ),
          Place(
            id: 'CAI-04',
            destinationId: 'CAI-01',
            name: 'Al-Azhar Park & Hilltop Dining',
            description:
            'A tranquil oasis offering panoramic city views of Cairo Citadel.',
            image: 'assets/images/cairo.png',
            category: 'Scenic Views & Parks',
            price: 150,
            opensAt: '09:00 AM',
            closesAt: '10:00 PM',
            budgetTier: 'Budget (\$)',
          ),
          Place(
            id: 'ALEX-01',
            destinationId: 'ALEX-01',
            name: 'Qaitbay Citadel',
            description:
            'Historic seaside fortress overlooking the Mediterranean Sea.',
            image: 'assets/images/alex.png',
            category: 'Historical & Ancient',
            price: 100,
            opensAt: '09:00 AM',
            closesAt: '05:00 PM',
          ),
          Place(
            id: 'ALEX-02',
            destinationId: 'ALEX-01',
            name: 'Alexandria Corniche',
            description:
            'Enjoy beautiful sea views along the Mediterranean coastline.',
            image: 'assets/images/alex.png',
            category: 'Scenic Views & Parks',
            price: 0,
            freeEntry: true,
          ),
          Place(
            id: 'SH-01',
            destinationId: 'SH-01',
            name: 'Naama Bay Beach',
            description:
            'Enjoy the Red Sea, clear water, and beautiful beach activities.',
            image: 'assets/images/sharm.png',
            category: 'Beaches',
            price: 250,
            opensAt: '08:00 AM',
            closesAt: '06:00 PM',
          ),
          Place(
            id: 'SH-02',
            destinationId: 'SH-01',
            name: 'Ras Mohammed National Park',
            description:
            'Explore amazing coral reefs and marine life in the Red Sea.',
            image: 'assets/images/sharm.png',
            category: 'Adventure',
            price: 300,
          ),
        ],
      ),
    );
  }

  void addPlace(Place place) {
    emit(
      state.copyWith(
        places: [...state.places, place],
      ),
    );
  }

  void updatePlace(Place updatedPlace) {
    final updated = state.places.map((place) {
      return place.id == updatedPlace.id ? updatedPlace : place;
    }).toList();

    emit(state.copyWith(places: updated));
  }

  void deletePlace(String id) {
    emit(
      state.copyWith(
        places: state.places
            .where((place) => place.id != id)
            .toList(),
      ),
    );
  }

  Place? getPlace(String id) {
    try {
      return state.places.firstWhere(
            (place) => place.id == id,
      );
    } catch (_) {
      return null;
    }
  }

  String generateId() {
    return 'PLC-${DateTime.now().millisecondsSinceEpoch}';
  }
}
