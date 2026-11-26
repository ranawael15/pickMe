import 'package:flutter/material.dart';
import 'package:pick_me/core/theme/app_colors.dart';
import 'package:pick_me/core/utils/auth_dialog.dart';
import 'package:pick_me/core/widgets/auth_button.dart';
import 'package:pick_me/features/auth/presentation/widgets/input_field_widget.dart';

import '../../services/auth_service.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final emailController = TextEditingController();
  final authService = AuthService();

  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();


  Future<void> sendResetEmail() async {
    if (emailController.text.trim().isEmpty) {
      showAuthDialog(context, message: 'Please enter your email');
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      await authService.forgotPassword(email: emailController.text.trim());

      if (!mounted) return;

     showAuthDialog(context, message: 'If the account exists, a reset email will be sent.');
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

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(title: const Text('Forgot Password'),backgroundColor: AppColors.backgroundColor,),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Enter your email to receive a password reset link.',
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 25),

              InputFieldWidget(
                controller: emailController,
                text: "Email Address",
                hintText: "e.g. sarah.traveler@gmail.com",
                prefixIcon: Icons.email_outlined,
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



              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: MaterialButton(
                  color: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  onPressed: isLoading ? null : sendResetEmail,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: isLoading
                        ? const CircularProgressIndicator()
                        : const Text('Send Reset Link'),
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
