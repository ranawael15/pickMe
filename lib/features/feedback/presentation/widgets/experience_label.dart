import 'package:flutter/material.dart';

class ExperienceLabel extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const ExperienceLabel({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  static const Color yellowColor = Color(0xFFF8D967);
  static const Color darkBrown = Color(0xFF302318);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? yellowColor : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: yellowColor, width: 1.2),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: darkBrown,
            fontSize: 13,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
