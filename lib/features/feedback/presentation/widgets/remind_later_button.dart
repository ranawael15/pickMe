import 'package:flutter/material.dart';

class RemindLaterButton extends StatelessWidget {
  final VoidCallback onPressed;

  const RemindLaterButton({super.key, required this.onPressed});

  static const Color darkBrown = Color(0xFF302318);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: darkBrown,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      ),
      child: const Text(
        'Remind me later',
        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
      ),
    );
  }
}
