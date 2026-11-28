import 'package:flutter/material.dart';

class RatingStars extends StatelessWidget {
  final int selectedRating;
  final ValueChanged<int> onRatingSelected;

  const RatingStars({
    super.key,
    required this.selectedRating,
    required this.onRatingSelected,
  });

  static const Color yellowColor = Color(0xFFF8D967);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        final rating = index + 1;
        final isSelected = rating <= selectedRating;

        return IconButton(
          onPressed: () {
            onRatingSelected(rating);
          },
          icon: Icon(
            isSelected ? Icons.star : Icons.star_border,
            color: yellowColor,
            size: 38,
          ),
        );
      }),
    );
  }
}
