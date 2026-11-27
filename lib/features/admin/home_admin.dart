import 'package:flutter/material.dart';
import 'package:pick_me/features/admin/profile/admin_profile.dart';
import 'package:pick_me/features/auth/logic/provider/auth_provider.dart';
import 'package:provider/provider.dart';

import '../auth/services/auth_service.dart';

class HomeAdmin extends StatefulWidget {
  const HomeAdmin({super.key,});

  @override
  State<HomeAdmin> createState() => _HomeAdminState();
}

class _HomeAdminState extends State<HomeAdmin> {
  Future<void> handleLogout() async {
    try {
      await AuthService().logout();

      if (!mounted) return;

      Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Logout failed: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider=Provider.of<AuthProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text("admin  ${authProvider.user!.userMetadata?['full_name']?.toString().trim()}"),
            ElevatedButton(
              onPressed: () {
                handleLogout();
              },
              child: Text("logout"),
            ),

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AdminProfile(),
                  ),
                );
              },
              child: Text("admin"),
            ),
          ],
        ),
      ),
    );
  }
}
