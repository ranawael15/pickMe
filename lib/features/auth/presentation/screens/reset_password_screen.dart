
import 'package:flutter/material.dart';
import 'package:pick_me/core/theme/app_colors.dart';
import 'package:pick_me/core/utils/auth_dialog.dart';
import 'package:pick_me/features/auth/logic/services/auth_service.dart';
import 'package:pick_me/features/auth/presentation/widgets/input_field_widget.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() =>
      _ResetPasswordScreenState();
}

class _ResetPasswordScreenState
    extends State<ResetPasswordScreen> {

  final formKey = GlobalKey<FormState>();

  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final authService = AuthService();

  bool obscurePassword = true;
  bool obscureConfirmPassword = true;
  bool isLoading = false;

  Future<void> resetPassword() async {
    if (!formKey.currentState!.validate()) return;

    setState(() {
      isLoading = true;
    });

    try {
      // Update new password
      await authService.updatePassword(
        passwordController.text,
      );

      // Clear session and Remember Me
      await authService.logout();

      if (!mounted) return;

      showAuthDialog(context, message: 'Password updated successfully!');

      Navigator.pushNamedAndRemoveUntil(
        context,
        '/login',
            (route) => false,
      );

    } catch (e) {
      if (!mounted) return;

     showAuthDialog(context, message: 'Error: $e');

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
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryPale,

      appBar: AppBar(
        backgroundColor: AppColors.primaryPale,

        title: const Text('Reset Password'),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Form(
          key: formKey,

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              const Text(
                'Create a new password',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 30),

              InputFieldWidget(
                  text: "",
                  prefixIcon: Icons.lock,
                  hintText: "New password",
              controller: passwordController,
                obscureText: obscurePassword,
                suffixIcon: IconButton(onPressed: () {
                                setState(() {
                                obscurePassword = !obscurePassword;
                                });}, icon: Icon(obscurePassword
                                                    ? Icons.visibility_off
                                                    : Icons.visibility,)),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your new password';
                  }

                  if (value.length < 8) {
                    return 'Password must be at least 8 characters';
                  }

                  return null;
                },
              ),



              InputFieldWidget(
                text: "",
                prefixIcon: Icons.lock,
                hintText: 'Confirm Password',
                controller: confirmPasswordController,
                obscureText: obscureConfirmPassword,
                suffixIcon: IconButton(
                  icon: Icon(
                    obscureConfirmPassword
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                  onPressed: () {
                    setState(() {
                      obscureConfirmPassword =
                      !obscureConfirmPassword;
                    });
                  },

                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please confirm your password';
                  }

                  if (value != passwordController.text) {
                    return 'Passwords do not match';
                  }

                  return null;
                },

              ),



              const SizedBox(height: 25),

              SizedBox(
                width: double.infinity,

                child: MaterialButton(
                  color:AppColors.primary,

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),

                  onPressed: isLoading ? null : resetPassword,

                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: isLoading
                        ? const CircularProgressIndicator()
                        : const Text('Update Password'),

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
