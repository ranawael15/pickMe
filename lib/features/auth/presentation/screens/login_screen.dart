import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pick_me/core/theme/app_colors.dart';
import 'package:pick_me/core/utils/auth_dialog.dart';
import 'package:pick_me/features/auth/logic/provider/auth_provider.dart';

import 'package:pick_me/features/auth/presentation/screens/register_Screen.dart';
import 'package:pick_me/features/auth/presentation/widgets/input_field_widget.dart';
import 'package:provider/provider.dart';

import '../../services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _authService = AuthService();

  bool obscureText = true;
  bool checkBox = false;
  bool isLoading = false;

  Future<void> _submitForm() async {

    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      isLoading = true;
    });



    try {
      setState(() {
        isLoading = true;
      });

      final user = await _authService.login(
        email: _emailController.text,
        password: _passwordController.text,
      );

      await _authService.saveRememberMe(checkBox);

      final isAdmin =
      (user.email ?? '').toLowerCase().contains('@admin');

      if (!mounted) return;

      Navigator.pushNamedAndRemoveUntil(
        context,
        isAdmin ? '/admin' : '/home',
            (route) => false,
        arguments: displayName,
      );

    } catch (e) {
      showAuthDialog(context, message: e.toString());
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }



  }
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider=Provider.of<AuthProvider>(context);

    Future<void> _submitForm() async {
      if (!_formKey.currentState!.validate()) {
        return;
      }

      setState(() {
        isLoading = true;
      });

      try {
        final user = await _authService.login(
          email: _emailController.text,
          password: _passwordController.text,
        );

        authProvider.changeUser(user);


        await _authService.saveRememberMe(checkBox);

        final isAdmin = (user.email ?? '').toLowerCase().contains('@admin');

        if (!mounted) return;

        Navigator.pushNamedAndRemoveUntil(
          context,
          isAdmin ? '/admin_profile' : '/home',
              (route) => false,
        );
      } catch (e) {
        if (!mounted) return;

          showAuthDialog(context, message: e.toString());
      } finally {
        if (mounted) {
          setState(() {
            isLoading = false;
          });
        }
      }
    }


    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              spacing: 15,
              children: [
                Image.asset("assets/images/pickme_logo.png"),

                const Text(
                  "Welcome back! 👋",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 30),
                ),

                InputFieldWidget(
                  text: "Email Address",
                  hintText: "e.g. sarah.traveler@gmail.com",
                  prefixIcon: Icons.email_outlined,
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your email';
                    }

                    if (!RegExp(
                      r'^[^@\s]+@[^@\s]+\.[^@\s]+$',
                    ).hasMatch(value.trim())) {
                      return 'Please enter a valid email';
                    }

                    return null;
                  },
                ),

                InputFieldWidget(
                  text: "Password",
                  hintText: ".........",
                  prefixIcon: Icons.lock,
                  controller: _passwordController,
                  obscureText: obscureText,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password';
                    }

                    return null;
                  },
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        obscureText = !obscureText;
                      });
                    },
                    icon: Icon(
                      obscureText ? Icons.visibility_off : Icons.visibility,
                    ),
                  ),
                ),

                Row(
                  children: [
                    Checkbox(
                      value: checkBox,
                      onChanged: (value) {
                        setState(() {
                          checkBox = value ?? false;
                        });
                      },
                      side: BorderSide.none,
                      fillColor: const WidgetStatePropertyAll(
                        Color(0xFFFFEAD7),
                      ),
                      checkColor: Colors.black,
                    ),

                    const Text("Remember me"),

                    const Spacer(),

                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/forgot-password');
                      },
                      child: const Text('Forgot Password?'),
                    ),
                  ],
                ),

                SizedBox(
                  width: double.infinity,
                  child: MaterialButton(
                    color: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    onPressed: isLoading ? null : _submitForm,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            isLoading ? "Signing In..." : "Sign In to PickMe ",
                          ),
                          const Icon(Icons.arrow_forward),
                        ],
                      ),
                    ),
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account?   "),

                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RegisterScreen(),
                          ),
                        );
                      },
                      child: const Text("Create an account"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
