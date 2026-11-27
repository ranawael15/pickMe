
import 'package:flutter/material.dart';

class CharacterCounter extends StatelessWidget {
  final int currentLength;
  final int maxLength;

  const CharacterCounter({
    super.key,
    required this.currentLength,
    this.maxLength = 500,
  });

  static const Color darkBrown = Color(0xFF302318);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Text(
        '$currentLength/$maxLength',
        style: const TextStyle(
          color: darkBrown,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
