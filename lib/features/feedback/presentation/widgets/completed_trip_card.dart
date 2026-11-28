import 'package:flutter/material.dart';

class CompletedJourneyCard extends StatelessWidget {
  final String destinationName;
  final String imageUrl;
  final String tripDate;

  const CompletedJourneyCard({
    super.key,
    required this.destinationName,
    required this.imageUrl,
    required this.tripDate,
  });

  static const Color yellowColor = Color(0xFFF8D967);
  static const Color darkBrown = Color(0xFF302318);
  static const Color secondaryBrown = Color(0xFF685744);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: yellowColor.withOpacity(0.7)),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              imageUrl,
              width: 95,
              height: 100,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 95,
                  height: 100,
                  color: yellowColor.withOpacity(0.3),
                  child: const Icon(
                    Icons.image_not_supported_outlined,
                    color: secondaryBrown,
                  ),
                );
              },
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  destinationName,
                  style: const TextStyle(
                    color: darkBrown,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 7),
                const Row(
                  children: [
                    Icon(Icons.check_circle, color: Colors.green, size: 16),
                    SizedBox(width: 5),
                    Text(
                      'Completed Journey',
                      style: TextStyle(color: secondaryBrown, fontSize: 12),
                    ),
                  ],
                ),
                const SizedBox(height: 7),
                Row(
                  children: [
                    const Icon(
                      Icons.calendar_today_outlined,
                      color: secondaryBrown,
                      size: 14,
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: Text(
                        tripDate,
                        style: const TextStyle(
                          color: secondaryBrown,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
