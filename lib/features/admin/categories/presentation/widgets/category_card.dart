import 'package:flutter/material.dart';

import '../../data/models/category_model.dart';

class CategoryCard extends StatelessWidget {
  final CategoryModel category;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const CategoryCard({
    super.key,
    required this.category,
    required this.onEdit,
    required this.onDelete,
  });

  static const Color darkColor = Color(0xFF302419);
  static const Color mutedColor = Color(0xFF716453);

  @override
  Widget build(BuildContext context) {
    final hasDescription =
        category.description != null && category.description!.trim().isNotEmpty;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.045),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Category Name
          Text(
            category.name,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: darkColor,
            ),
          ),

          // Category Description
          if (hasDescription) ...[
            const SizedBox(height: 6),
            Text(
              category.description!.trim(),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 12,
                height: 1.5,
                color: mutedColor,
              ),
            ),
          ],

          const SizedBox(height: 14),

          // Action Buttons
          Row(
            children: [
              // Edit Button
              ElevatedButton.icon(
                onPressed: onEdit,
                icon: const Icon(Icons.edit_outlined, size: 15),
                label: const Text('Edit', style: TextStyle(fontSize: 11)),
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: const Color(0xFFE7D8C5),
                  foregroundColor: const Color(0xFF55432F),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 17,
                  ),
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  shape: const StadiumBorder(),
                ),
              ),

              const SizedBox(width: 9),

              // Delete Circular Button
              SizedBox(
                width: 36,
                height: 36,
                child: IconButton(
                  onPressed: onDelete,
                  icon: const Icon(Icons.delete_outline, size: 18),
                  style: IconButton.styleFrom(
                    backgroundColor: const Color(0XFFFFDAD6),
                    foregroundColor: const Color(0XFF93000A),
                    padding: EdgeInsets.zero,
                    shape: const CircleBorder(),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
