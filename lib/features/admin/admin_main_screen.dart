
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:pick_me/features/admin/bottomNavBar/admin_bottom_nav_bar.dart';
import 'package:pick_me/features/admin/clients/presentation/screens/clients_screen.dart';
import 'package:pick_me/features/admin/dashboard/presentation/screens/admin_dashboard_screen.dart';
import 'package:pick_me/features/admin/destinations/presentation/screens/destinations_screen.dart';
import 'package:pick_me/features/admin/destinations/presentation/screens/destination_form_screen.dart';
import 'package:pick_me/features/admin/categories/presentation/screens/categories_screen.dart';
import 'package:pick_me/features/admin/categories/presentation/screens/category_form_screen.dart';
import 'package:pick_me/features/admin/categories/logic/cubit/categories_cubit.dart';

class AdminMainScreen extends StatefulWidget {
  const AdminMainScreen({super.key});

  @override
  State<AdminMainScreen> createState() => _AdminMainScreenState();
}

class _AdminMainScreenState extends State<AdminMainScreen> {
  int selectedIndex = 0;

  void _onItemSelected(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  // Dashboard shortcuts are separate from Bottom Navigation.
  void _handleDashboardNavigation(int index) {
    if (index == 1) {
      _onItemSelected(1); // Destinations
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DestinationFormScreen(),
        ),
      );
    } else if (index == 3) {
      _onItemSelected(2); // Categories
    } else if (index == 4) {
      _onItemSelected(3); // Clients
    } else if (index == 5) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CategoryFormScreen(
            cubit: context.read<CategoriesCubit>(),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: selectedIndex,
        children: [
          AdminDashboardScreen(
            onNavigate: _handleDashboardNavigation,
          ),
          DestinationsScreen(),
          const CategoriesScreen(),
          const ClientsScreen(),
        ],
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
            bottom: 12,
            top: 8,
          ),
          child: AdminBottomNavBar(
            selectedIndex: selectedIndex,
            onItemSelected: _onItemSelected,
          ),
        ),
      ),
    );
  }
}
