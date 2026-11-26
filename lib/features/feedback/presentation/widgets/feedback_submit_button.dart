
import 'package:flutter/material.dart';

class FeedbackSubmitButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isLoading;

  const FeedbackSubmitButton({
    super.key,
    required this.onPressed,
    this.isLoading = false,
  });

  static const Color yellowColor = Color(0xFFF8D967);
  static const Color darkBrown = Color(0xFF302318);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: yellowColor,
          foregroundColor: darkBrown,
          disabledBackgroundColor: yellowColor.withOpacity(0.6),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: isLoading
            ? const SizedBox(
          width: 22,
          height: 22,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: darkBrown,
          ),
        )
            : const Text(
          'Submit Feedback',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
