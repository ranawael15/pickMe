import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pick_me/features/auth/logic/provider/auth_provider.dart';
import 'package:provider/provider.dart';

import '../../trip_request/logic/cubit/trip_request_cubit.dart';
import 'budget_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const Color backgroundColor = Color(0xFFFFF8F4);
  static const Color yellowColor = Color(0xFFF8D967);
  static const Color darkBrown = Color(0xFF302318);
  static const Color secondaryBrown = Color(0xFF685744);

  static const List<Map<String, String>> destinations = [
    {
      'id': 'f6b063fb-a0fa-4ffe-b5e5-07b0c353126b',
      'name': 'Cairo',
      'subtitle': 'The heart of Egypt',
      'image': 'assets/images/imgs/cairo.jpg',
    },
    {
      'id': 'ace3866a-4725-4bc3-a72f-a46633c1dd4d',
      'name': 'Alexandria',
      'subtitle': 'The pearl of the Mediterranean',
      'image': 'assets/images/imgs/alexandria.jpg',
    },
    {
      'id': 'fd7c28db-48c9-498b-b363-a2979c150cc6',
      'name': 'Sharm El Sheikh',
      'subtitle': 'Discover the Red Sea',
      'image': 'assets/images/imgs/sharm.jpg',
    },
  ];

  void selectDestination(
    BuildContext context,
    String destination,
    String destinationId,
  ) {
    context.read<TripRequestCubit>().setDestination(destination, destinationId);

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const BudgetScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final authProvider=Provider.of<AuthProvider>(context);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                   Expanded(
                    child: Text(
                      'Morning, ${authProvider.user!.userMetadata?['full_name']?.toString().trim()}! 👋',
                      style: TextStyle(
                        color: darkBrown,
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  CircleAvatar(
                    backgroundColor: yellowColor,
                    child: IconButton(
                      icon: const Icon(Icons.person, color: darkBrown),
                      onPressed: (){
                        Navigator.pushNamed(
                          context,
                          "/profile",
                        );

                      },),
                  ),
                ],
              ),
              const SizedBox(height: 35),
              const Text(
                'STEP 1 OF 3',
                style: TextStyle(
                  color: secondaryBrown,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Set Your Destination',
                style: TextStyle(
                  color: darkBrown,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Where would you like to go?',
                style: TextStyle(color: secondaryBrown, fontSize: 15),
              ),
              const SizedBox(height: 22),
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: const LinearProgressIndicator(
                  value: 0.34,
                  minHeight: 7,
                  backgroundColor: Color(0xFFEBDCC8),
                  valueColor: AlwaysStoppedAnimation(yellowColor),
                ),
              ),
              const SizedBox(height: 28),
              ...destinations.map((destination) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 18),
                  child: DestinationCard(
                    name: destination['name']!,
                    subtitle: destination['subtitle']!,
                    image: destination['image']!,
                    onTap: () {
                      selectDestination(
                        context,
                        destination['name']!,
                        destination['id']!,
                      );
                    },
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}

class DestinationCard extends StatelessWidget {
  final String name;
  final String subtitle;
  final String image;
  final VoidCallback onTap;

  const DestinationCard({
    super.key,
    required this.name,
    required this.subtitle,
    required this.image,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 175,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
              color: Colors.brown.withOpacity(0.10),
              blurRadius: 12,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(22),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                image,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: const Color(0xFFEBDCC8),
                    child: const Icon(
                      Icons.image_not_supported_outlined,
                      size: 40,
                      color: Color(0xFF685744),
                    ),
                  );
                },
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.75),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 18,
                right: 18,
                bottom: 18,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: const TextStyle(color: Colors.white, fontSize: 13),
                    ),
                  ],
                ),
              ),
              const Positioned(
                right: 18,
                top: 18,
                child: CircleAvatar(
                  radius: 18,
                  backgroundColor: Color(0xFFF8D967),
                  child: Icon(
                    Icons.arrow_forward,
                    color: Color(0xFF302318),
                    size: 19,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
