import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/cubit/places_cubit.dart';

class PlaceFormScreen extends StatefulWidget {
  final String destinationId;
  final Place? place;

  const PlaceFormScreen({super.key, required this.destinationId, this.place});

  @override
  State<PlaceFormScreen> createState() => _PlaceFormScreenState();
}

class _PlaceFormScreenState extends State<PlaceFormScreen> {
  static const Color background = Color(0xFFFFF8F4);
  static const Color primary = Color(0xFFF8DB69);
  static const Color peach = Color(0xFFFFEFE3);
  static const Color dark = Color(0xFF302419);
  static const Color muted = Color(0xFF716453);

  final formKey = GlobalKey<FormState>();

  late TextEditingController nameController;
  late TextEditingController descriptionController;
  late TextEditingController priceController;

  String selectedImage = 'assets/images/cairo.png';
  String selectedCategory = 'Historical & Ancient';
  String selectedBudget = 'Moderate (\$\$)';
  String opensAt = '09:00 AM';
  String closesAt = '05:00 PM';

  bool freeEntry = false;
  bool visible = true;

  bool get isEditing => widget.place != null;

  final List<String> categories = const [
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

  @override
  void initState() {
    super.initState();

    final place = widget.place;

    nameController = TextEditingController(text: place?.name ?? '');

    descriptionController = TextEditingController(
      text: place?.description ?? '',
    );

    priceController = TextEditingController(
      text: place == null || place.freeEntry
          ? ''
          : place.price.toStringAsFixed(0),
    );

    if (place != null) {
      selectedImage = place.image;
      selectedCategory = place.category;
      selectedBudget = place.budgetTier;
      opensAt = place.opensAt;
      closesAt = place.closesAt;
      freeEntry = place.freeEntry;
      visible = place.visible;
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
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
          isEditing ? 'Edit Place' : 'New Place',
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
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 30),
          children: [
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: peach,
                borderRadius: BorderRadius.circular(24),
              ),
              child: const Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Color(0xFFF8DB69),
                    child: Icon(Icons.location_city, color: Color(0xFF806600)),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Destination Hub',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: dark,
                      ),
                    ),
                  ),
                  Icon(Icons.swap_horiz),
                ],
              ),
            ),

            const SizedBox(height: 25),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'Place Imagery *',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Aspect 16:9',
                  style: TextStyle(color: muted, fontSize: 11),
                ),
              ],
            ),

            const SizedBox(height: 12),

            GestureDetector(
              onTap: _chooseImage,
              child: Container(
                height: 190,
                decoration: BoxDecoration(
                  color: peach,
                  borderRadius: BorderRadius.circular(30),
                ),
                clipBehavior: Clip.antiAlias,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(selectedImage, fit: BoxFit.cover),
                    Container(color: Colors.black.withOpacity(.25)),
                    const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 25,
                          backgroundColor: primary,
                          child: Icon(
                            Icons.add_photo_alternate_outlined,
                            color: Color(0xFF806600),
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Upload Cover Hero Photo',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Tap to choose an available image',
                          style: TextStyle(color: Colors.white, fontSize: 11),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 28),

            const Text(
              'General Information',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: dark,
              ),
            ),

            const SizedBox(height: 18),

            _label('Place / Landmark Name *'),

            TextFormField(
              controller: nameController,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Place name is required';
                }
                if (value.trim().length < 2) {
                  return 'Enter a valid place name';
                }
                return null;
              },
              decoration: _decoration('e.g. Sultan Hassan Mosque & Madrasa'),
            ),

            const SizedBox(height: 18),

            _label('Category *'),

            DropdownButtonFormField<String>(
              value: selectedCategory,
              decoration: _decoration('Select category'),
              items: categories.map((category) {
                return DropdownMenuItem(
                  value: category,
                  child: Text(category, style: const TextStyle(fontSize: 13)),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() => selectedCategory = value);
                }
              },
            ),

            const SizedBox(height: 18),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _label('Curated Description & Tips'),
                Text(
                  '${descriptionController.text.length}/600',
                  style: const TextStyle(fontSize: 10, color: muted),
                ),
              ],
            ),

            TextFormField(
              controller: descriptionController,
              maxLength: 600,
              maxLines: 4,
              onChanged: (_) => setState(() {}),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Description is required';
                }
                if (value.trim().length < 10) {
                  return 'Description must be at least 10 characters';
                }
                return null;
              },
              decoration:
                  _decoration(
                    'Highlight architectural details, views, dress code, or tips...',
                  ).copyWith(
                    counterText: '',
                    alignLabelWithHint: true,
                    contentPadding: const EdgeInsets.all(16),
                  ),
            ),

            const SizedBox(height: 22),

            Container(
              padding: const EdgeInsets.all(17),
              decoration: BoxDecoration(
                color: peach,
                borderRadius: BorderRadius.circular(27),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Expanded(
                        child: Text(
                          'Budget Tier & Admission',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: dark,
                          ),
                        ),
                      ),
                      const Text('Free Entry', style: TextStyle(fontSize: 11)),
                      Checkbox(
                        activeColor: const Color(0xFF806600),
                        value: freeEntry,
                        onChanged: (value) {
                          setState(() {
                            freeEntry = value ?? false;
                            if (freeEntry) {
                              priceController.clear();
                            }
                          });
                        },
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  const Text('Budget Tier', style: TextStyle(fontSize: 12)),

                  const SizedBox(height: 8),

                  DropdownButtonFormField<String>(
                    value: selectedBudget,
                    decoration: _decoration('Budget tier'),
                    items:
                        const [
                          'Budget (\$)',
                          'Moderate (\$\$)',
                          'Luxury / VIP (\$\$\$)',
                        ].map((tier) {
                          return DropdownMenuItem(
                            value: tier,
                            child: Text(
                              tier,
                              style: const TextStyle(fontSize: 13),
                            ),
                          );
                        }).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() => selectedBudget = value);
                      }
                    },
                  ),

                  const SizedBox(height: 15),

                  const Text(
                    'Standard Entry Ticket (EGP)',
                    style: TextStyle(fontSize: 12),
                  ),

                  const SizedBox(height: 8),

                  TextFormField(
                    controller: priceController,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    enabled: !freeEntry,
                    validator: (value) {
                      if (freeEntry) return null;

                      if (value == null || value.trim().isEmpty) {
                        return 'Enter ticket price or select Free Entry';
                      }

                      final price = double.tryParse(value);

                      if (price == null || price < 0) {
                        return 'Enter a valid price';
                      }

                      return null;
                    },
                    decoration: _decoration(
                      '180',
                    ).copyWith(prefixText: 'EGP  '),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 27),

            const Text(
              'Hours & Timing',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: dark,
              ),
            ),

            const SizedBox(height: 15),

            Row(
              children: [
                Expanded(
                  child: _timeButton(
                    'Opens At',
                    opensAt,
                    Icons.access_time,
                    true,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _timeButton(
                    'Closes At',
                    closesAt,
                    Icons.access_time,
                    false,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 22),

            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              activeColor: const Color(0xFF806600),
              title: const Text(
                'Visible to Clients',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
              subtitle: const Text(
                'Allow clients to see this place',
                style: TextStyle(fontSize: 11),
              ),
              value: visible,
              onChanged: (value) {
                setState(() => visible = value);
              },
            ),

            const SizedBox(height: 25),

            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: SizedBox(
                    height: 55,
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: const Color(0xFFF3E1CF),
                        foregroundColor: dark,
                        shape: const StadiumBorder(),
                      ),
                      child: const Text('Discard'),
                    ),
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(
                  flex: 2,
                  child: SizedBox(
                    height: 55,
                    child: ElevatedButton.icon(
                      onPressed: _savePlace,
                      icon: const Icon(Icons.check_circle_outline),
                      label: Text(isEditing ? 'Save Changes' : 'Publish Place'),
                      style: ElevatedButton.styleFrom(
                        elevation: 2,
                        backgroundColor: primary,
                        foregroundColor: const Color(0xFF806600),
                        shape: const StadiumBorder(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
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

  InputDecoration _decoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(fontSize: 12, color: Color(0xFF91816C)),
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(22),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(22),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(22),
        borderSide: const BorderSide(color: primary, width: 1.5),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    );
  }

  Widget _timeButton(String label, String value, IconData icon, bool isOpen) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 11, color: muted)),
        const SizedBox(height: 8),
        InkWell(
          borderRadius: BorderRadius.circular(30),
          onTap: () => _selectTime(isOpen),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            decoration: BoxDecoration(
              color: peach,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              children: [
                Icon(icon, size: 17, color: muted),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    value,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _selectTime(bool isOpen) async {
    final initial = _parseTime(isOpen ? opensAt : closesAt);

    final picked = await showTimePicker(context: context, initialTime: initial);

    if (picked == null) return;

    final formatted = _formatTime(picked);

    setState(() {
      if (isOpen) {
        opensAt = formatted;
      } else {
        closesAt = formatted;
      }
    });
  }

  TimeOfDay _parseTime(String value) {
    try {
      final parts = value.split(' ');
      final time = parts[0].split(':');

      int hour = int.parse(time[0]);
      final minute = int.parse(time[1]);

      if (parts[1] == 'PM' && hour != 12) hour += 12;
      if (parts[1] == 'AM' && hour == 12) hour = 0;

      return TimeOfDay(hour: hour, minute: minute);
    } catch (_) {
      return const TimeOfDay(hour: 9, minute: 0);
    }
  }

  String _formatTime(TimeOfDay time) {
    final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;

    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.period == DayPeriod.am ? 'AM' : 'PM';

    return '$hour:$minute $period';
  }

  void _chooseImage() {
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
                'Choose Place Image',
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
            ],
          ),
        );
      },
    );
  }

  void _savePlace() {
    if (!formKey.currentState!.validate()) return;

    final cubit = context.read<PlacesCubit>();

    final place = Place(
      id: widget.place?.id ?? cubit.generateId(),
      destinationId: widget.destinationId,
      name: nameController.text.trim(),
      description: descriptionController.text.trim(),
      image: selectedImage,
      category: selectedCategory,
      price: freeEntry ? 0 : double.parse(priceController.text.trim()),
      freeEntry: freeEntry,
      visible: visible,
      opensAt: opensAt,
      closesAt: closesAt,
      budgetTier: selectedBudget,
    );

    if (isEditing) {
      cubit.updatePlace(place);
    } else {
      cubit.addPlace(place);
    }

    Navigator.pop(context);
  }
}
