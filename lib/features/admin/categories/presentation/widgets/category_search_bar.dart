import 'package:flutter/material.dart';

class CategorySearchBar extends StatelessWidget {
  final ValueChanged<String> onChanged;

  const CategorySearchBar({super.key, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: 'Search categories or keywords...',
        hintStyle: const TextStyle(fontSize: 13, color: Color(0xFF9A8B79)),
        prefixIcon: const Icon(
          Icons.search,
          color: Color(0xFF716453),
          size: 20,
        ),
        suffixIcon: const Icon(Icons.tune, color: Color(0xFF716453), size: 19),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(vertical: 15),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(
            color: const Color(0xFFF8DB69).withOpacity(0.7),
            width: 1,
          ),
        ),
      ),
    );
  }
}
