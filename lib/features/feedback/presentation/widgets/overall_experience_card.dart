import 'package:flutter/material.dart';

import 'rating_stars.dart';

class OverallExperienceCard extends StatelessWidget {
  final int selectedRating;
  final ValueChanged<int> onRatingSelected;

  const OverallExperienceCard({
    super.key,
    required this.selectedRating,
    required this.onRatingSelected,
  });

  static const Color darkBrown = Color(0xFF302318);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Overall Experience',
            style: TextStyle(
              color: darkBrown,
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          RatingStars(
            selectedRating: selectedRating,
            onRatingSelected: onRatingSelected,
          ),
        ],
      ),
    );
  }
}
