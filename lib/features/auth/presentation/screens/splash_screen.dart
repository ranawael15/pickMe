
import 'package:flutter/material.dart';
import 'package:pick_me/core/theme/app_colors.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:pick_me/features/auth/logic/services/auth_service.dart';

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
      // Give Supabase a moment to process an incoming recovery link.
      await Future.delayed(const Duration(milliseconds: 500));

      if (!mounted) return;

      final supabase = Supabase.instance.client;

      // If a recovery session exists, do not sign out.
      // The auth listener in main.dart will navigate to ResetPasswordScreen.
      if (supabase.auth.currentSession != null &&
          supabase.auth.currentUser != null) {
        final user = supabase.auth.currentUser!;

        final name = user.userMetadata?['full_name']?.toString();

        final userName = (name == null || name.trim().isEmpty)
            ? (user.email ?? '').split('@').first
            : name;

        final isAdmin =
        (user.email ?? '').toLowerCase().contains('@admin');

        // The main.dart listener handles passwordRecovery navigation.
        // This check alone cannot distinguish recovery from normal login.
        final isRemembered = await authService.checkRememberMe();

        if (!mounted) return;

        if (!isRemembered) {
          Navigator.pushReplacementNamed(context, '/login');
          return;
        }

        Navigator.pushReplacementNamed(
          context,
          isAdmin ? '/admin' : '/home',
          arguments: userName,
        );

        return;
      }

      final isLoggedIn = await authService.checkRememberMe();

      if (!mounted) return;

      if (!isLoggedIn) {
        Navigator.pushReplacementNamed(context, '/login');
        return;
      }

      final user = supabase.auth.currentUser;

      if (user == null) {
        Navigator.pushReplacementNamed(context, '/login');
        return;
      }

      final name = user.userMetadata?['full_name']?.toString();

      final userName = (name == null || name.trim().isEmpty)
          ? (user.email ?? '').split('@').first
          : name;

      final isAdmin =
      (user.email ?? '').toLowerCase().contains('@admin');

      Navigator.pushReplacementNamed(
        context,
        isAdmin ? '/admin' : '/home',
        arguments: userName,
      );
    } catch (e) {
      debugPrint('Splash error: $e');

      if (!mounted) return;

      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryPale,

      body: Center(
        child: Image.asset('assets/images/pickme_logo.png'),
      ),
    );
  }
}
