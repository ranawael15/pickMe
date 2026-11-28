import 'package:flutter/material.dart';

class FeedbackFooter extends StatelessWidget {
  const FeedbackFooter({super.key});

  static const Color secondaryBrown = Color(0xFF685744);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.lock_outline, color: secondaryBrown, size: 16),
          SizedBox(width: 7),
          Text(
            'Private & encrypted',
            style: TextStyle(color: secondaryBrown, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
