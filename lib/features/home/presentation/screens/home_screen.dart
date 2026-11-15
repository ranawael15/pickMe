import 'package:flutter/material.dart';
import 'package:pick_me/core/utils/auth_dialog.dart';
import 'package:pick_me/features/auth/logic/services/auth_service.dart';

class HomeScreen extends StatefulWidget {
  final String userName;

  const HomeScreen({
    super.key,
    required this.userName,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<void> handleLogout() async {
    try {
      await AuthService().logout();

      if (!mounted) return;

      Navigator.pushNamedAndRemoveUntil(
        context,
        '/login',
            (route) => false,
      );
    } catch (e) {
      if (!mounted) return;

      showAuthDialog(context, message: 'Logout failed: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
              children: [
                Text("hello user  ${widget.userName}"),
                ElevatedButton(onPressed:(){
                  handleLogout();
                }, child: Text("logout"))

              ])),
    );
  }
}
