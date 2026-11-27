
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../destinations/logic/cubit/destinations_cubit.dart';

class AdminDashboardScreen extends StatelessWidget {
  final ValueChanged<int> onNavigate;

  const AdminDashboardScreen({
    super.key,
    required this.onNavigate,
  });

  static const Color background = Color(0xFFFFF8F4);
  static const Color primary = Color(0xFFF8DB69);
  static const Color peach = Color(0xFFFFEFE3);
  static const Color dark = Color(0xFF302419);
  static const Color muted = Color(0xFF716453);

  @override
  Widget build(BuildContext context) {
    final destinations =
        context.watch<DestinationsCubit>().state.destinations;

    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(22, 22, 22, 25),
          children: [
            Row(
              children: [
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome, Admin',
                        style: TextStyle(
                          fontSize: 27,
                          fontWeight: FontWeight.bold,
                          color: dark,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'PickMe Operations & Content Management',
                        style: TextStyle(
                          fontSize: 13,
                          color: muted,
                        ),
                      ),
                    ],
                  ),
                ),
                CircleAvatar(
                  backgroundColor: const Color(0xFF806600),
                  radius: 21,
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.person_outline,
                      color: Colors.white,
                      size: 21,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 25),

            ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Image.asset(
                'assets/images/imgs/cairo.jpg',
                height: 145,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 24),

            _managementCard(
              title: 'Manage Destinations',
              count: '${destinations.length} Active',
              subtitle:
              'View, add, edit, or remove travel destinations (Cairo, Alexandria, Sharm El Sheikh)',
              icon: Icons.location_on_outlined,
              iconColor: primary,
              onTap: () => onNavigate(1),
            ),

            const SizedBox(height: 15),

            _managementCard(
              title: 'Manage Categories',
              count: '12 Categories',
              subtitle:
              'Organize destination experiences, historical tours, beach & nightlife',
              icon: Icons.category_outlined,
              iconColor: const Color(0xFFEDE0C8),
              onTap: () {},
            ),

            const SizedBox(height: 15),

            _managementCard(
              title: 'Manage Clients',
              count: '1,420 Clients',
              subtitle:
              'View registered travelers, profile details, and account status',
              icon: Icons.groups_outlined,
              iconColor: const Color(0xFFE9DA9D),
              onTap: () {},
            ),

            const SizedBox(height: 30),

            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Quick Shortcuts',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: dark,
                  ),
                ),
                Text(
                  'Instant Creation',
                  style: TextStyle(
                    fontSize: 11,
                    color: muted,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 14),

            Row(
              children: [
                Expanded(
                  child: _shortcut(
                    '+ New Destination',
                    Icons.add_location_alt_outlined,
                    primary,
                        () => onNavigate(2),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _shortcut(
                    '+ New Category',
                    Icons.bookmark_add_outlined,
                    const Color(0xFFEDE0C8),
                        () {},
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            Center(
              child: TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.visibility_outlined),
                label: const Text('Switch to Client View'),
                style: TextButton.styleFrom(
                  backgroundColor: peach,
                  foregroundColor: dark,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 22,
                    vertical: 14,
                  ),
                  shape: const StadiumBorder(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _managementCard({
    required String title,
    required String count,
    required String subtitle,
    required IconData icon,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(30),
      child: Container(
        padding: const EdgeInsets.all(17),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.035),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: iconColor,
                  child: Icon(
                    icon,
                    color: const Color(0xFF806600),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: dark,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: peach,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          count,
                          style: const TextStyle(fontSize: 10),
                        ),
                      ),
                    ],
                  ),
                ),
                const CircleAvatar(
                  radius: 18,
                  backgroundColor: peach,
                  child: Icon(
                    Icons.arrow_forward,
                    color: dark,
                    size: 19,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              subtitle,
              style: const TextStyle(
                fontSize: 12,
                color: muted,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _shortcut(
      String title,
      IconData icon,
      Color color,
      VoidCallback onTap,
      ) {
    return ElevatedButton.icon(
      onPressed: onTap,
      icon: Icon(icon, size: 17),
      label: Text(
        title,
        style: const TextStyle(fontSize: 11),
      ),
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: color,
        foregroundColor: const Color(0xFF806600),
        padding: const EdgeInsets.symmetric(vertical: 17),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );
  }
}
