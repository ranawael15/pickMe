import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/cubit/places_cubit.dart';

class PlaceDetailsScreen extends StatelessWidget {
  final String placeId;

  const PlaceDetailsScreen({super.key, required this.placeId});

  static const Color background = Color(0xFFFFF8F4);
  static const Color primary = Color(0xFFF8DB69);
  static const Color peach = Color(0xFFFFEFE3);
  static const Color dark = Color(0xFF302419);
  static const Color muted = Color(0xFF716453);

  @override
  Widget build(BuildContext context) {
    final place = context.watch<PlacesCubit>().getPlace(placeId);

    if (place == null) {
      return const Scaffold(body: Center(child: Text('Place not found')));
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
          place.name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: dark,
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(28),
            child: Stack(
              children: [
                Image.asset(
                  place.image,
                  height: 250,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    padding: const EdgeInsets.all(17),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(.75),
                        ],
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'DESTINATION LANDMARK',
                          style: TextStyle(fontSize: 10, color: Colors.white),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          place.name,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  place.name,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: dark,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 11,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: primary,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  '★ 4.9',
                  style: TextStyle(
                    color: Color(0xFF806600),
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          Text(
            place.category,
            style: const TextStyle(fontSize: 13, color: muted),
          ),

          const SizedBox(height: 20),

          Row(
            children: [
              Expanded(
                child: _infoCard(
                  Icons.payments_outlined,
                  place.freeEntry
                      ? 'Free'
                      : '${place.price.toStringAsFixed(0)} EGP',
                  'Entry Ticket',
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _infoCard(
                  Icons.schedule,
                  '3 - 4 Hrs',
                  'Suggested Duration',
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _infoCard(
                  Icons.wb_sunny_outlined,
                  place.opensAt,
                  'Opens At',
                ),
              ),
            ],
          ),

          const SizedBox(height: 22),

          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(28),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'About this Landmark',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: dark,
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  place.description,
                  style: const TextStyle(
                    fontSize: 14,
                    height: 1.7,
                    color: muted,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(28),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.access_time, color: Color(0xFF806600)),
                    const SizedBox(width: 8),
                    const Expanded(
                      child: Text(
                        'Operating Schedule',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: dark,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFD9F8E9),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        '● Active',
                        style: TextStyle(
                          color: Color(0xFF238B54),
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 22),

                _scheduleRow('Opens At', place.opensAt),
                const SizedBox(height: 15),
                _scheduleRow('Closes At', place.closesAt),
                const SizedBox(height: 15),
                _scheduleRow('Budget Tier', place.budgetTier),
                const SizedBox(height: 15),
                _scheduleRow(
                  'Client Visibility',
                  place.visible ? 'Visible' : 'Hidden',
                ),
              ],
            ),
          ),

          const SizedBox(height: 25),

          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () => _confirmDelete(context, place),
                  icon: const Icon(Icons.delete_outline),
                  label: const Text('Delete Place'),
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: const Color(0xFFFFDDDA),
                    foregroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(vertical: 17),
                    shape: const StadiumBorder(),
                  ),
                ),
              ),

              const SizedBox(width: 10),

              Expanded(
                flex: 2,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                    // The edit action is available from the
                    // destination places list.
                  },
                  icon: const Icon(Icons.edit_outlined),
                  label: const Text('Edit Place Details'),
                  style: ElevatedButton.styleFrom(
                    elevation: 2,
                    backgroundColor: primary,
                    foregroundColor: const Color(0xFF806600),
                    padding: const EdgeInsets.symmetric(vertical: 17),
                    shape: const StadiumBorder(),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _infoCard(IconData icon, String value, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 13),
      decoration: BoxDecoration(
        color: peach,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Icon(icon, size: 18, color: const Color(0xFF806600)),
          const SizedBox(height: 7),
          Text(
            value,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: dark,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 9, color: muted),
          ),
        ],
      ),
    );
  }

  Widget _scheduleRow(String label, String value) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: const TextStyle(fontSize: 12, color: muted),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: dark,
            ),
          ),
        ),
      ],
    );
  }

  void _confirmDelete(BuildContext context, Place place) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: background,
          title: const Text('Delete Place?'),
          content: Text('Are you sure you want to delete ${place.name}?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                context.read<PlacesCubit>().deletePlace(place.id);
                Navigator.pop(dialogContext);
                Navigator.pop(context);
              },
              child: const Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }
}
