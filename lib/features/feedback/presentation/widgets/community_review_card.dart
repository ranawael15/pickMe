
import 'package:flutter/material.dart';

class CommunityReviewCard extends StatelessWidget {
  final String userName;
  final String timeAgo;
  final int rating;
  final String comment;

  const CommunityReviewCard({
    super.key,
    required this.userName,
    required this.timeAgo,
    required this.rating,
    required this.comment,
  });

  static const Color yellowColor = Color(0xFFF8D967);
  static const Color darkBrown = Color(0xFF302318);
  static const Color secondaryBrown = Color(0xFF685744);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: yellowColor.withOpacity(0.5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: yellowColor.withOpacity(0.4),
                child: const Icon(
                  Icons.person,
                  color: darkBrown,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userName,
                      style: const TextStyle(
                        color: darkBrown,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      timeAgo,
                      style: const TextStyle(
                        color: secondaryBrown,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(
                  5,
                      (index) => Icon(
                    index < rating
                        ? Icons.star
                        : Icons.star_border,
                    color: yellowColor,
                    size: 17,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            comment,
            style: const TextStyle(
              color: secondaryBrown,
              fontSize: 13,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
