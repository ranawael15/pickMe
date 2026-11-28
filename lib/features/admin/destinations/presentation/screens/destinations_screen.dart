import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/cubit/destinations_cubit.dart';
import '../../logic/cubit/destinations_state.dart';
import 'destination_form_screen.dart';
import 'destinations_details_screen.dart';

class DestinationsScreen extends StatelessWidget {
  const DestinationsScreen({super.key});

  static const Color background = Color(0xFFFFF8F4);
  static const Color primary = Color(0xFFF8DB69);
  static const Color peach = Color(0xFFFFEFE3);
  static const Color dark = Color(0xFF302419);
  static const Color muted = Color(0xFF716453);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        child: BlocBuilder<DestinationsCubit, DestinationsState>(
          builder: (context, state) {
            final destinations = state.filteredDestinations;

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(22, 25, 22, 15),
                  child: Row(
                    children: [
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Destinations',
                              style: TextStyle(
                                fontSize: 27,
                                fontWeight: FontWeight.bold,
                                color: dark,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Manage all travel hubs available to clients',
                              style: TextStyle(color: muted, fontSize: 13),
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const DestinationFormScreen(),
                            ),
                          );
                        },
                        icon: const Icon(Icons.add, size: 18),
                        label: const Text(
                          'Add Destination',
                          style: TextStyle(fontSize: 11),
                        ),
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: primary,
                          foregroundColor: const Color(0xFF806600),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 13,
                            vertical: 15,
                          ),
                          shape: const StadiumBorder(),
                        ),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22),
                  child: TextField(
                    onChanged: context
                        .read<DestinationsCubit>()
                        .searchDestinations,
                    decoration: InputDecoration(
                      hintText: 'Search hubs by city or landmark...',
                      hintStyle: const TextStyle(
                        fontSize: 13,
                        color: Color(0xFF9A8B79),
                      ),
                      prefixIcon: const Icon(Icons.search, color: muted),
                      filled: true,
                      fillColor: peach,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                Expanded(
                  child: destinations.isEmpty
                      ? const Center(
                          child: Text(
                            'No destinations found',
                            style: TextStyle(color: muted),
                          ),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.fromLTRB(22, 0, 22, 25),
                          itemCount: destinations.length,
                          itemBuilder: (context, index) {
                            final destination = destinations[index];

                            return Padding(
                              padding: const EdgeInsets.only(bottom: 17),
                              child: _destinationCard(context, destination),
                            );
                          },
                        ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _destinationCard(BuildContext context, Destination destination) {
    return Container(
      padding: const EdgeInsets.all(15),
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
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      DestinationDetailsScreen(destinationId: destination.id),
                ),
              );
            },
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(3),
                  child: Image.asset(
                    destination.image,
                    height: 175,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      height: 175,
                      color: peach,
                      child: const Icon(Icons.image_outlined),
                    ),
                  ),
                ),
                Positioned(
                  right: 12,
                  bottom: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 11,
                      vertical: 7,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(.95),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '${destination.categories.length} Categories linked',
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 15),

          Row(
            children: [
              Expanded(
                child: Text(
                  destination.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: dark,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: peach,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  destination.region,
                  style: const TextStyle(
                    fontSize: 10,
                    color: Color(0xFF806600),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 7),

          Text(
            destination.description,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 12, height: 1.5, color: muted),
          ),

          const SizedBox(height: 15),

          Row(
            children: [
              Expanded(
                child: _actionButton(
                  title: 'Edit',
                  icon: Icons.edit_outlined,
                  background: const Color(0xFFF3EBDD),
                  foreground: muted,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            DestinationFormScreen(destination: destination),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _actionButton(
                  title: 'Delete',
                  icon: Icons.delete_outline,
                  background: const Color(0xFFFFEEEE),
                  foreground: Colors.red,
                  onTap: () => _confirmDelete(context, destination),
                ),
              ),
            ],
          ),

          const SizedBox(height: 5),

          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        DestinationDetailsScreen(destinationId: destination.id),
                  ),
                );
              },
              child: const Text(
                'View Details →',
                style: TextStyle(
                  color: Color(0xFF806600),
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _actionButton({
    required String title,
    required IconData icon,
    required Color background,
    required Color foreground,
    required VoidCallback onTap,
  }) {
    return ElevatedButton.icon(
      onPressed: onTap,
      icon: Icon(icon, size: 16),
      label: Text(title),
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: background,
        foregroundColor: foreground,
        padding: const EdgeInsets.symmetric(vertical: 12),
        shape: const StadiumBorder(),
      ),
    );
  }

  void _confirmDelete(BuildContext context, Destination destination) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: background,
          title: const Text('Delete Destination?'),
          content: Text('Are you sure you want to delete ${destination.name}?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                context.read<DestinationsCubit>().deleteDestination(
                  destination.id,
                );

                Navigator.pop(dialogContext);
              },
              child: const Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }
}
