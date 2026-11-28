import 'package:flutter/material.dart';

import '../../data/models/category_model.dart';
import '../../logic/cubit/categories_cubit.dart';

class CategoryFormScreen extends StatefulWidget {
  final CategoriesCubit cubit;
  final CategoryModel? category;

  const CategoryFormScreen({super.key, required this.cubit, this.category});

  @override
  State<CategoryFormScreen> createState() => _CategoryFormScreenState();
}

class _CategoryFormScreenState extends State<CategoryFormScreen> {
  static const Color background = Color(0xFFFFF8F4);
  static const Color yellow = Color(0xFFF8DB69);
  static const Color dark = Color(0xFF302419);
  static const Color muted = Color(0xFF716453);

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();

  final Set<String> _selectedDestinationIds = {};

  bool _isSaving = false;

  bool get _isEditing => widget.category != null;

  @override
  void initState() {
    super.initState();

    final category = widget.category;

    if (category != null) {
      _nameController.text = category.name;
      _descriptionController.text = category.description ?? '';
      _selectedDestinationIds.addAll(category.destinationIds);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _saveCategory() async {
    if (!_formKey.currentState!.validate()) return;

    if (_selectedDestinationIds.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select at least one destination')),
      );
      return;
    }

    setState(() => _isSaving = true);

    try {
      if (_isEditing) {
        await widget.cubit.updateCategory(
          categoryId: widget.category!.id,
          name: _nameController.text.trim(),
          description: _descriptionController.text.trim(),
          destinationIds: _selectedDestinationIds.toList(),
        );
      } else {
        await widget.cubit.addCategory(
          name: _nameController.text.trim(),
          description: _descriptionController.text.trim(),
          destinationIds: _selectedDestinationIds.toList(),
        );
      }

      if (!mounted) return;

      final error = widget.cubit.state.errorMessage;

      if (error != null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Save failed: $error')));
        return;
      }

      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _isEditing
                ? 'Category updated successfully'
                : 'Category added successfully',
          ),
        ),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Something went wrong: $e')));
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final destinations = widget.cubit.state.destinations;

    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: background,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, color: dark),
        ),
        title: Text(
          _isEditing ? 'Edit Category' : 'New Category',
          style: const TextStyle(
            color: dark,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Related Destination
                    const Text(
                      'Related Destination *',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: dark,
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      'Required Hub',
                      style: TextStyle(fontSize: 11, color: muted),
                    ),
                    const SizedBox(height: 14),

                    if (destinations.isEmpty)
                      const Text(
                        'No destinations available.',
                        style: TextStyle(color: muted),
                      )
                    else
                      Wrap(
                        spacing: 9,
                        runSpacing: 10,
                        children: destinations.map((destination) {
                          final id = destination['id'] as String;
                          final name = destination['name'] as String;
                          final isSelected = _selectedDestinationIds.contains(
                            id,
                          );

                          return InkWell(
                            borderRadius: BorderRadius.circular(25),
                            onTap: () {
                              setState(() {
                                if (isSelected) {
                                  _selectedDestinationIds.remove(id);
                                } else {
                                  _selectedDestinationIds.add(id);
                                }
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15,
                                vertical: 11,
                              ),
                              decoration: BoxDecoration(
                                color: isSelected ? yellow : Colors.white,
                                borderRadius: BorderRadius.circular(25),
                                border: Border.all(
                                  color: isSelected
                                      ? yellow
                                      : const Color(0xFFEAE2D9),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    isSelected
                                        ? Icons.check_circle
                                        : Icons.location_on_outlined,
                                    size: 15,
                                    color: dark,
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    name,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: dark,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),

                    const SizedBox(height: 28),

                    // Category Name
                    const Text(
                      'Category Name *',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: dark,
                      ),
                    ),
                    const SizedBox(height: 10),

                    TextFormField(
                      controller: _nameController,
                      textInputAction: TextInputAction.next,
                      decoration: _inputDecoration(hint: 'Enter category name'),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Category name is required';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 25),

                    // Description
                    const Text(
                      'Description *',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: dark,
                      ),
                    ),
                    const SizedBox(height: 10),

                    TextFormField(
                      controller: _descriptionController,
                      maxLength: 300,
                      maxLines: 5,
                      onChanged: (_) => setState(() {}),
                      decoration: _inputDecoration(
                        hint: 'Describe this experience category...',
                      ).copyWith(alignLabelWithHint: true, counterText: ''),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Description is required';
                        }
                        return null;
                      },
                    ),

                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        '${_descriptionController.text.length}/300',
                        style: const TextStyle(fontSize: 11, color: muted),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Bottom Buttons
            Container(
              padding: const EdgeInsets.fromLTRB(20, 15, 20, 22),
              decoration: const BoxDecoration(
                color: background,
                border: Border(top: BorderSide(color: Color(0xFFEFE7DF))),
              ),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: _isSaving ? null : _saveCategory,
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: yellow,
                        foregroundColor: dark,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: _isSaving
                          ? const SizedBox(
                              width: 22,
                              height: 22,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: dark,
                              ),
                            )
                          : Text(
                              _isEditing ? 'Update Category' : 'Save Category',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: TextButton(
                      onPressed: _isSaving
                          ? null
                          : () => Navigator.pop(context),
                      style: TextButton.styleFrom(
                        backgroundColor: const Color(0xFFF0E9E2),
                        foregroundColor: dark,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: const Text(
                        'Cancel & Discard',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration _inputDecoration({required String hint}) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(fontSize: 12, color: Color(0xFFB0A69B)),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(13),
        borderSide: const BorderSide(color: Color(0xFFEAE2D9)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(13),
        borderSide: const BorderSide(color: Color(0xFFEAE2D9)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(13),
        borderSide: const BorderSide(color: yellow, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(13),
        borderSide: const BorderSide(color: Colors.redAccent),
      ),
    );
  }
}
