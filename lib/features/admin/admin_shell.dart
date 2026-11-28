import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'dashboard/logic/cubit/dashboard_cubit.dart';
import 'dashboard/presentation/screens/admin_dashboard_screen.dart';

import 'destinations/presentation/screens/destinations_screen.dart';
import 'destinations/presentation/screens/destination_form_screen.dart';

class AdminShell extends StatelessWidget {
  const AdminShell({super.key});

  static const Color background = Color(0xFFFFF8F4);
  static const Color primary = Color(0xFFF8DB69);
  static const Color dark = Color(0xFF302419);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardCubit, dynamic>(
      builder: (context, state) {
        final selectedIndex = context
            .watch<DashboardCubit>()
            .state
            .selectedIndex;

        return Scaffold(
          backgroundColor: background,
          body: IndexedStack(
            index: selectedIndex,
            children: [
              AdminDashboardScreen(
                onNavigate: (index) {
                  if (index == 1) {
                    context.read<DashboardCubit>().changeTab(1);
                  } else if (index == 2) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const DestinationFormScreen(),
                      ),
                    );
                  }
                },
              ),
              const DestinationsScreen(),
            ],
          ),
          bottomNavigationBar: SafeArea(
            minimum: const EdgeInsets.fromLTRB(20, 0, 20, 12),
            child: Container(
              height: 65,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(35),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(.06),
                    blurRadius: 15,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  _navItem(
                    context,
                    0,
                    Icons.grid_view_rounded,
                    'Dashboard',
                    selectedIndex,
                  ),
                  _navItem(
                    context,
                    1,
                    Icons.explore_outlined,
                    'Destinations',
                    selectedIndex,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _navItem(
    BuildContext context,
    int index,
    IconData icon,
    String title,
    int selectedIndex,
  ) {
    final selected = selectedIndex == index;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          context.read<DashboardCubit>().changeTab(index);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: selected ? primary : Colors.transparent,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: dark, size: 21),
              const SizedBox(height: 3),
              Text(title, style: const TextStyle(color: dark, fontSize: 11)),
            ],
          ),
        ),
      ),
    );
  }
}
