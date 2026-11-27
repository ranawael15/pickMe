
import 'package:flutter/material.dart';

class FeedbackAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;
  final VoidCallback onBack;

  const FeedbackAppBar({
    super.key,
    required this.title,
    required this.onBack,
  });

  static const Color darkBrown = Color(0xFF302318);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFFFFF8F4),
      elevation: 0,
      leading: IconButton(
        onPressed: onBack,
        icon: const Icon(
          Icons.arrow_back_ios_new,
          color: darkBrown,
          size: 20,
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: darkBrown,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
