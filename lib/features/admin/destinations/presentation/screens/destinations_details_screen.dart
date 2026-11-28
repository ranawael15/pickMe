import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/cubit/destinations_cubit.dart';
import '../../../places/logic/cubit/places_cubit.dart';
import '../../../places/logic/cubit/places_state.dart';
import '../../../places/presentation/screens/place_details_screen.dart';
import '../../../places/presentation/screens/place_form_screen.dart';

class DestinationDetailsScreen extends StatelessWidget {
  final String destinationId;

  const DestinationDetailsScreen({super.key, required this.destinationId});

  static const Color background = Color(0xFFFFF8F4);
  static const Color primary = Color(0xFFF8DB69);
  static const Color peach = Color(0xFFFFEFE3);
  static const Color dark = Color(0xFF302419);
  static const Color muted = Color(0xFF716453);

  @override
  Widget build(BuildContext context) {
    final destination = context.watch<DestinationsCubit>().getDestination(
      destinationId,
    );

    if (destination == null) {
      return const Scaffold(body: Center(child: Text('Destination not found')));
    }

    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: background,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, color: dark),
        ),
        title: Text(
          '${destination.name} Details',
          style: const TextStyle(
            color: dark,
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: BlocBuilder<PlacesCubit, PlacesState>(
        builder: (context, state) {
          final places = state.placesForDestination(destinationId);

          return ListView(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
            children: [
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: peach,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  children: [
                    const CircleAvatar(
                      backgroundColor: primary,
                      child: Icon(
                        Icons.location_city,
                        color: Color(0xFF806600),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        '${destination.name} Hub',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      style: TextButton.styleFrom(
                        backgroundColor: const Color(0xFFF3E0CC),
                        foregroundColor: dark,
                      ),
                      child: const Text('Switch ↔'),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 18),

              ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Stack(
                  children: [
                    Image.asset(
                      destination.image,
                      height: 185,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      left: 12,
                      top: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          '● Active / Visible to Clients',
                          style: TextStyle(
                            fontSize: 10,
                            color: Color(0xFF348A4E),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 12,
                      top: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          'ID: ${destination.id}',
                          style: const TextStyle(fontSize: 9),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 15,
                      bottom: 14,
                      child: Text(
                        '${destination.name} Hub Overview',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(color: Colors.black54, blurRadius: 8),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 14),

              Row(
                children: [
                  _statCard(
                    places.length.toString(),
                    'Linked Places',
                    Icons.location_on_outlined,
                  ),
                  const SizedBox(width: 10),
                  _statCard(
                    destination.categories.length.toString(),
                    'Categories',
                    Icons.category_outlined,
                  ),
                ],
              ),

              const SizedBox(height: 22),

              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          PlaceFormScreen(destinationId: destinationId),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: primary,
                    borderRadius: BorderRadius.circular(28),
                  ),
                  child: const Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.add_location_alt_outlined,
                          color: Color(0xFF806600),
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '+ Add New Place',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: dark,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Add an attraction, landmark, or activity',
                              style: TextStyle(fontSize: 11, color: muted),
                            ),
                          ],
                        ),
                      ),
                      Icon(Icons.arrow_forward),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 22),

              if (places.isEmpty)
                const Padding(
                  padding: EdgeInsets.all(25),
                  child: Center(
                    child: Text(
                      'No places added yet',
                      style: TextStyle(color: muted),
                    ),
                  ),
                ),

              ...places.map((place) {
                return _placeCard(context, place);
              }),
            ],
          );
        },
      ),
    );
  }

  Widget _statCard(String value, String label, IconData icon) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 17),
        decoration: BoxDecoration(
          color: peach,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          children: [
            Icon(icon, color: const Color(0xFF806600), size: 20),
            const SizedBox(height: 5),
            Text(
              value,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: dark,
              ),
            ),
            Text(label, style: const TextStyle(fontSize: 11, color: muted)),
          ],
        ),
      ),
    );
  }

  Widget _placeCard(BuildContext context, Place place) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.035),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(17),
                child: Image.asset(
                  place.image,
                  width: double.infinity,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(left: 9, top: 9, child: _chip(place.budgetTier)),
              Positioned(
                right: 9,
                top: 9,
                child: _chip(
                  place.freeEntry
                      ? 'Free Admission'
                      : '${place.price.toStringAsFixed(0)} EGP',
                ),
              ),
              Positioned(
                right: 9,
                bottom: 9,
                child: _chip(place.visible ? '● Visible' : '● Hidden'),
              ),
            ],
          ),

          const SizedBox(height: 12),

          Row(
            children: [
              Expanded(
                child: Text(
                  place.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: dark,
                  ),
                ),
              ),
              Text(
                '#${place.id}',
                style: const TextStyle(fontSize: 9, color: muted),
              ),
            ],
          ),

          const SizedBox(height: 7),

          Text(
            place.description,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 11, height: 1.5, color: muted),
          ),

          const SizedBox(height: 12),

          Wrap(
            spacing: 7,
            runSpacing: 7,
            children: [
              _smallTag(Icons.category_outlined, place.category),
              _smallTag(
                Icons.access_time,
                '${place.opensAt} - ${place.closesAt}',
              ),
            ],
          ),

          const SizedBox(height: 12),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              color: peach,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    place.visible ? '◉ Shown to users' : '○ Hidden from users',
                    style: const TextStyle(fontSize: 10, color: muted),
                  ),
                ),
                IconButton(
                  visualDensity: VisualDensity.compact,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => PlaceFormScreen(
                          destinationId: place.destinationId,
                          place: place,
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.edit_outlined, size: 19),
                ),
                IconButton(
                  visualDensity: VisualDensity.compact,
                  onPressed: () => _deletePlace(context, place),
                  icon: const Icon(
                    Icons.delete_outline,
                    color: Colors.red,
                    size: 19,
                  ),
                ),
              ],
            ),
          ),

          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => PlaceDetailsScreen(placeId: place.id),
                  ),
                );
              },
              child: const Text(
                'View Details →',
                style: TextStyle(fontSize: 11, color: Color(0xFF806600)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _chip(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFFFE78B),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 9,
          fontWeight: FontWeight.w600,
          color: dark,
        ),
      ),
    );
  }

  Widget _smallTag(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFFFEBDD),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: muted),
          const SizedBox(width: 4),
          Text(text, style: const TextStyle(fontSize: 9, color: muted)),
        ],
      ),
    );
  }

  void _deletePlace(BuildContext context, Place place) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: background,
          title: const Text('Delete Place?'),
          content: Text('Delete ${place.name}?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                context.read<PlacesCubit>().deletePlace(place.id);
                Navigator.pop(dialogContext);
              },
              child: const Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }
}
