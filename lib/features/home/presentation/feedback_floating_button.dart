
import 'package:flutter/material.dart';

class FeedbackFloatingButton extends StatelessWidget {
  final VoidCallback onPressed;

  const FeedbackFloatingButton({
    super.key,
    required this.onPressed,
  });

  static const Color yellowColor = Color(0xFFF8D967);
  static const Color darkBrown = Color(0xFF302318);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: yellowColor,
      shape: const CircleBorder(),
      elevation: 5,
      child: InkWell(
        onTap: onPressed,
        customBorder: const CircleBorder(),
        child: const SizedBox(
          width: 58,
          height: 58,
          child: Icon(
            Icons.thumb_up_alt_outlined,
            color: darkBrown,
            size: 27,
          ),
        ),
      ),
    );
  }
}
