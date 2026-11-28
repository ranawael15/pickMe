import 'package:flutter/material.dart';

class DestinationFilter extends StatelessWidget {
  final List<Map<String, dynamic>> destinations;
  final String? selectedDestinationId;
  final int totalCategories;
  final int Function(String? destinationId) getCategoryCount;
  final ValueChanged<String?> onDestinationSelected;

  const DestinationFilter({
    super.key,
    required this.destinations,
    required this.selectedDestinationId,
    required this.totalCategories,
    required this.getCategoryCount,
    required this.onDestinationSelected,
  });

  static const Color yellowColor = Color(0xFFF8DB69);
  static const Color darkColor = Color(0xFF302419);
  static const Color mutedColor = Color(0xFF716453);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'FILTER BY DESTINATION',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: mutedColor,
                letterSpacing: 0.3,
              ),
            ),
            Text(
              '${destinations.length} Active',
              style: const TextStyle(fontSize: 10, color: mutedColor),
            ),
          ],
        ),

        const SizedBox(height: 10),

        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _filterChip(
                title: 'All',
                count: totalCategories,
                isSelected: selectedDestinationId == null,
                onTap: () => onDestinationSelected(null),
              ),

              ...destinations.map((destination) {
                final id = destination['id'] as String;
                final name = destination['name'] as String;

                return Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: _filterChip(
                    title: name,
                    count: getCategoryCount(id),
                    isSelected: selectedDestinationId == id,
                    onTap: () => onDestinationSelected(id),
                  ),
                );
              }),
            ],
          ),
        ),
      ],
    );
  }

  Widget _filterChip({
    required String title,
    required int count,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Material(
      color: isSelected ? yellowColor : Colors.white,
      borderRadius: BorderRadius.circular(25),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(25),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 9),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (isSelected && title != 'All') ...[
                const Icon(
                  Icons.location_on_outlined,
                  size: 13,
                  color: darkColor,
                ),
                const SizedBox(width: 4),
              ],

              Text(
                '$title ($count)',
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: darkColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
