import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../services/auth_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final authService = AuthService();

  @override
  void initState() {
    super.initState();
    checkUser();
  }

  Future<void> checkUser() async {
    try {
      final isLoggedIn = await authService.checkRememberMe();

      if (!mounted) return;

      if (!isLoggedIn) {
        Navigator.pushReplacementNamed(context, '/login');
        return;
      }

      final user = Supabase.instance.client.auth.currentUser;

      if (user == null) {
        Navigator.pushReplacementNamed(context, '/login');
        return;
      }

      final name = user.userMetadata?['full_name']?.toString();

      final userName = (name == null || name.trim().isEmpty)
          ? (user.email ?? '').split('@').first
          : name.trim();

      final isAdmin = (user.email ?? '').toLowerCase().contains('@admin');

      Navigator.pushReplacementNamed(
        context,
        isAdmin ? '/admin' : '/home',
        arguments: userName,
      );
    } catch (e) {
      if (!mounted) return;

      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Image.asset("assets/images/pickme_logo.png")],
          ),
        ],
      ),
    );
  }
}
