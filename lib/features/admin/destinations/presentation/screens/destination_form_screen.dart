import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/cubit/destinations_cubit.dart';

class DestinationFormScreen extends StatefulWidget {
  final Destination? destination;

  const DestinationFormScreen({super.key, this.destination});

  @override
  State<DestinationFormScreen> createState() => _DestinationFormScreenState();
}

class _DestinationFormScreenState extends State<DestinationFormScreen> {
  static const Color background = Color(0xFFFFF8F4);
  static const Color primary = Color(0xFFF8DB69);
  static const Color peach = Color(0xFFFFEFE3);
  static const Color dark = Color(0xFF302419);
  static const Color muted = Color(0xFF716453);

  final formKey = GlobalKey<FormState>();

  late TextEditingController nameController;
  late TextEditingController descriptionController;

  String selectedImage = 'assets/images/cairo.png';
  String selectedRegion = 'Greater Cairo';

  bool categoriesExpanded = false;

  final List<String> allCategories = const [
    'Historical & Ancient',
    'Museums & Culture',
    'Shopping & Cultural',
    'Scenic Views & Parks',
    'Food & Dining',
    'Beaches',
    'Adventure',
    'Water Activities',
    'Nightlife',
    'Family Activities',
    'Nature & Wildlife',
    'Religious Sites',
  ];

  List<String> selectedCategories = [];

  bool get isEditing => widget.destination != null;

  @override
  void initState() {
    super.initState();

    final destination = widget.destination;

    nameController = TextEditingController(text: destination?.name ?? '');

    descriptionController = TextEditingController(
      text: destination?.description ?? '',
    );

    selectedImage = destination?.image ?? selectedImage;
    selectedRegion = destination?.region ?? selectedRegion;

    selectedCategories = List.from(destination?.categories ?? []);
  }

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
          isEditing ? 'Edit Destination' : 'New Destination',
          style: const TextStyle(
            color: dark,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
      ),
      body: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 15, 20, 30),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text('Cover Showcase Photo *', style: TextStyle(fontSize: 13)),
                Text(
                  'Recommended 16:9',
                  style: TextStyle(color: Color(0xFF806600), fontSize: 11),
                ),
              ],
            ),

            const SizedBox(height: 10),

            GestureDetector(
              onTap: _showImagePicker,
              child: Container(
                height: 215,
                decoration: BoxDecoration(
                  color: peach,
                  borderRadius: BorderRadius.circular(35),
                ),
                clipBehavior: Clip.antiAlias,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(
                      selectedImage,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => const SizedBox(),
                    ),
                    Container(color: Colors.black.withOpacity(.27)),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const CircleAvatar(
                          radius: 32,
                          backgroundColor: primary,
                          child: Icon(
                            Icons.add_photo_alternate_outlined,
                            color: Color(0xFF806600),
                            size: 29,
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'Tap to upload cover image',
                          style: TextStyle(
                            color: dark,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 5),
                        const Text(
                          'Choose an available local image',
                          style: TextStyle(color: muted, fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 25),

            _label('Destination Name *'),

            TextFormField(
              controller: nameController,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter destination name';
                }
                if (value.trim().length < 2) {
                  return 'Name must contain at least 2 characters';
                }
                return null;
              },
              decoration: _inputDecoration(
                'e.g., Luxor & Aswan Valley',
                Icons.location_on_outlined,
              ),
            ),

            const SizedBox(height: 22),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _label('Region'),
                const Text(
                  'Optional',
                  style: TextStyle(color: muted, fontSize: 11),
                ),
              ],
            ),

            DropdownButtonFormField<String>(
              value: selectedRegion,
              decoration: _inputDecoration('Select region'),
              items:
                  const [
                    'Greater Cairo',
                    'North Coast',
                    'South Sinai',
                    'Upper Egypt',
                    'Red Sea',
                    'Other',
                  ].map((region) {
                    return DropdownMenuItem(value: region, child: Text(region));
                  }).toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() => selectedRegion = value);
                }
              },
            ),

            const SizedBox(height: 22),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _label('Description *'),
                Text(
                  '${descriptionController.text.length}/500',
                  style: const TextStyle(color: muted, fontSize: 11),
                ),
              ],
            ),

            TextFormField(
              controller: descriptionController,
              maxLength: 500,
              maxLines: 5,
              onChanged: (_) => setState(() {}),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter a description';
                }
                if (value.trim().length < 10) {
                  return 'Description must be at least 10 characters';
                }
                return null;
              },
              decoration:
                  _inputDecoration(
                    'Describe highlights, historic temples, Nile cruises...',
                  ).copyWith(
                    counterText: '',
                    alignLabelWithHint: true,
                    contentPadding: const EdgeInsets.all(17),
                  ),
            ),

            const SizedBox(height: 20),

            Container(
              decoration: BoxDecoration(
                color: peach,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Column(
                children: [
                  ListTile(
                    onTap: () {
                      setState(() {
                        categoriesExpanded = !categoriesExpanded;
                      });
                    },
                    leading: CircleAvatar(
                      backgroundColor: const Color(0xFFF1E1C5),
                      child: Text(
                        '${selectedCategories.length}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    title: const Text(
                      'LINKED CATEGORIES',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: Text(
                      '${selectedCategories.length} categories selected',
                      style: const TextStyle(fontSize: 10),
                    ),
                    trailing: Icon(
                      categoriesExpanded
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                    ),
                  ),

                  if (categoriesExpanded)
                    ...allCategories.map((category) {
                      return CheckboxListTile(
                        dense: true,
                        activeColor: const Color(0xFF806600),
                        title: Text(
                          category,
                          style: const TextStyle(fontSize: 13),
                        ),
                        value: selectedCategories.contains(category),
                        onChanged: (checked) {
                          setState(() {
                            if (checked == true) {
                              selectedCategories.add(category);
                            } else {
                              selectedCategories.remove(category);
                            }
                          });
                        },
                      );
                    }),
                ],
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              height: 57,
              child: ElevatedButton.icon(
                onPressed: _saveDestination,
                icon: const Icon(Icons.bookmark_add_outlined),
                label: Text(
                  isEditing ? 'Save Changes' : 'Save Destination',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  elevation: 3,
                  backgroundColor: primary,
                  foregroundColor: const Color(0xFF806600),
                  shape: const StadiumBorder(),
                ),
              ),
            ),

            const SizedBox(height: 10),

            SizedBox(
              height: 55,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: const Color(0xFFF3E8D8),
                  foregroundColor: muted,
                  shape: const StadiumBorder(),
                ),
                child: const Text('Cancel & Discard'),
              ),
            ),

            if (isEditing) ...[
              const SizedBox(height: 20),
              TextButton.icon(
                onPressed: _deleteDestination,
                icon: const Icon(Icons.delete_outline),
                label: const Text('Delete Destination'),
                style: TextButton.styleFrom(
                  foregroundColor: Colors.red,
                  backgroundColor: const Color(0xFFFFEEEE),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _label(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 9),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: dark,
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint, [IconData? icon]) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(fontSize: 13, color: Color(0xFF91816C)),
      prefixIcon: icon == null ? null : Icon(icon, color: muted, size: 20),
      filled: true,
      fillColor: Colors.white,
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
        borderSide: const BorderSide(color: primary, width: 1.5),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 17, vertical: 17),
    );
  }

  void _showImagePicker() {
    const images = [
      'assets/images/cairo.png',
      'assets/images/alex.png',
      'assets/images/sharm.png',
    ];

    showModalBottomSheet(
      context: context,
      backgroundColor: background,
      builder: (sheetContext) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Choose Destination Image',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 18),
              Row(
                children: images.map((image) {
                  return Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() => selectedImage = image);
                        Navigator.pop(sheetContext);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.asset(
                            image,
                            height: 90,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 15),
            ],
          ),
        );
      },
    );
  }

  void _saveDestination() {
    if (!formKey.currentState!.validate()) return;

    final cubit = context.read<DestinationsCubit>();

    final destination = Destination(
      id: widget.destination?.id ?? cubit.generateId(),
      name: nameController.text.trim(),
      description: descriptionController.text.trim(),
      image: selectedImage,
      region: selectedRegion,
      categories: List.from(selectedCategories),
    );

    if (isEditing) {
      cubit.updateDestination(destination);
    } else {
      cubit.addDestination(destination);
    }

    Navigator.pop(context);
  }

  void _deleteDestination() {
    final id = widget.destination!.id;

    context.read<DestinationsCubit>().deleteDestination(id);

    Navigator.pop(context);
    Navigator.pop(context);
  }
}
