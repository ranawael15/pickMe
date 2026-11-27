
import 'package:flutter/material.dart';

class CommunityReviewsHeader extends StatelessWidget {
  final double averageRating;
  final int totalReviews;

  const CommunityReviewsHeader({
    super.key,
    required this.averageRating,
    required this.totalReviews,
  });

  static const Color yellowColor = Color(0xFFF8D967);
  static const Color darkBrown = Color(0xFF302318);
  static const Color secondaryBrown = Color(0xFF685744);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Community Reviews',
          style: TextStyle(
            color: darkBrown,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            const Icon(
              Icons.star,
              color: yellowColor,
              size: 30,
            ),
            const SizedBox(width: 7),
            Text(
              averageRating.toStringAsFixed(1),
              style: const TextStyle(
                color: darkBrown,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                'Based on $totalReviews reviews',
                style: const TextStyle(
                  color: secondaryBrown,
                  fontSize: 13,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
