import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final supabase = Supabase.instance.client;

  Future<void> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    final response = await supabase.auth.signUp(
      email: email.trim(),
      password: password,
      data: {'full_name': name.trim()},
    );

    if (response.user == null) {
      throw Exception('Account creation failed');
    }
  }

  Future<User> login({required String email, required String password}) async {
    final response = await supabase.auth.signInWithPassword(
      email: email.trim(),
      password: password,
    );

    final user = response.user;

    if (user == null) {
      throw Exception('Login failed');
    }

    return user;
  }

  // Future<void> saveRememberMe(bool value) async {
  //   final prefs = await SharedPreferences.getInstance();
  //
  //   await prefs.setBool('remember_me', value);
  //
  //   if (value) {
  //     final expiry = DateTime.now().add(const Duration(days: 7));
  //
  //     await prefs.setString('session_expiry', expiry.toIso8601String());
  //   } else {
  //     await prefs.remove('session_expiry');
  //   }
  // }


  Future<void> saveRememberMe(bool value) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool('remember_me', value);

    if (value) {
      final expiry = DateTime.now().add(
        const Duration(days: 30),
      );

      await prefs.setString(
        'session_expiry',
        expiry.toIso8601String(),
      );
    } else {
      await prefs.remove('session_expiry');
    }
  }

  // Future<bool> checkRememberMe() async {
  //   final prefs = await SharedPreferences.getInstance();
  //
  //   final rememberMe = prefs.getBool('remember_me') ?? false;
  //
  //   if (!rememberMe) {
  //     await supabase.auth.signOut();
  //     return false;
  //   }
  //
  //   final expiryString = prefs.getString('session_expiry');
  //
  //   if (expiryString == null) {
  //     await supabase.auth.signOut();
  //     return false;
  //   }
  //
  //   try {
  //     final expiry = DateTime.parse(expiryString);
  //
  //     if (!DateTime.now().isBefore(expiry)) {
  //       await supabase.auth.signOut();
  //       return false;
  //     }
  //   } catch (_) {
  //     await supabase.auth.signOut();
  //     return false;
  //   }
  //
  //   return supabase.auth.currentSession != null;
  // }


  Future<bool> checkRememberMe() async {
    final prefs = await SharedPreferences.getInstance();

    final rememberMe = prefs.getBool('remember_me') ?? false;

    if (!rememberMe) {
      return false;
    }

    final expiryString = prefs.getString('session_expiry');

    if (expiryString == null) {
      return false;
    }

    final expiry = DateTime.tryParse(expiryString);

    if (expiry == null || !DateTime.now().isBefore(expiry)) {
      await prefs.setBool('remember_me', false);
      await prefs.remove('session_expiry');

      await supabase.auth.signOut();

      return false;
    }

    return supabase.auth.currentSession != null;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove('remember_me');
    await prefs.remove('session_expiry');

    await supabase.auth.signOut();
  }

  Future<void> forgotPassword({required String email}) async {
    await supabase.auth.resetPasswordForEmail(email.trim());
  }

  Future<void> updatePassword(String newPassword) async {
    await supabase.auth.updateUser(UserAttributes(password: newPassword));
  }
}
