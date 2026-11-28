import 'package:flutter/material.dart';

class FeedbackTextField extends StatelessWidget {
  final String initialValue;
  final ValueChanged<String> onChanged;
  final int maxLength;

  const FeedbackTextField({
    super.key,
    required this.initialValue,
    required this.onChanged,
    this.maxLength = 500,
  });

  static const Color yellowColor = Color(0xFFF8D967);
  static const Color darkBrown = Color(0xFF302318);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      onChanged: onChanged,
      maxLength: maxLength,
      maxLines: 5,
      decoration: InputDecoration(
        hintText: 'Share your experience with us...',
        hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 14),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.all(16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: yellowColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: yellowColor, width: 1.2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: darkBrown, width: 1.5),
        ),
        counterText: '',
      ),
    );
  }
}
