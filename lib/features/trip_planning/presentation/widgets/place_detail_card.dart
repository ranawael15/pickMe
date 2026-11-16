import 'package:flutter/material.dart';
import '../../data/models/place_model.dart';
import 'trip_theme_constants.dart';

class PlaceDetailCard extends StatelessWidget {
  final PlaceModel place;

  const PlaceDetailCard({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: TripColors.cardBg,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  place.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: TripColors.textDark,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: TripColors.peachBanner,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${place.estimatedCost.toStringAsFixed(0)} EGP',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: TripColors.textDark,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.category_outlined,
                size: 14,
                color: TripColors.textMuted,
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  'Category: ${place.categoryId}',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: TripColors.textMuted,
                  ),
                ),
              ),
            ],
          ),
          if (place.description != null &&
              place.description!.trim().isNotEmpty) ...[
            const SizedBox(height: 10),
            Text(
              place.description!,
              style: const TextStyle(
                fontSize: 12,
                height: 1.4,
                color: Color(0xFF57534E),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
