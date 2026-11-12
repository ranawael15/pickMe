import 'package:flutter/material.dart';
import 'package:pick_me/features/auth/logic/services/auth_service.dart';

class HomeAdmin extends StatefulWidget {
  final String userName;

  const HomeAdmin({
    super.key,
    required this.userName,
  });

  @override
  State<HomeAdmin> createState() => _HomeAdminState();
}

class _HomeAdminState extends State<HomeAdmin> {
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

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Logout failed: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
              children: [
                Text("admin  ${widget.userName}"),
                ElevatedButton(onPressed:(){
                  handleLogout();
                }, child: Text("logout"))

              ])),
    );
  }
}
