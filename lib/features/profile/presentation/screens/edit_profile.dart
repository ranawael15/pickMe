import 'package:flutter/material.dart';
import 'package:pick_me/core/theme/app_colors.dart';
import 'package:pick_me/core/utils/auth_dialog.dart';
import 'package:pick_me/core/widgets/auth_button.dart';
import 'package:pick_me/features/auth/logic/provider/auth_provider.dart';
import 'package:pick_me/features/auth/services/auth_service.dart';
import 'package:pick_me/features/profile/presentation/screens/profile_screen.dart';
import 'package:pick_me/features/profile/presentation/widgets/edit_profile_input.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class EditProfile extends StatefulWidget {
   const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();
  bool passwordObscureText = true;
  bool newPasswordObscureText = true;
  bool confirmNewPasswordObscureText = true;

  late String originalName;
  late String originalEmail;
  late String originalPhone;



  @override
  Widget build(BuildContext context) {
    final authProvider=Provider.of<AuthProvider>(context);

    late final nameController = TextEditingController(text:"${authProvider.user!.userMetadata?['full_name']!.toString().trim()}");

    final emailController = TextEditingController(text: authProvider.user!.email);

    final passwordController = TextEditingController();
    final currentPasswordController = TextEditingController();


    final phoneController = TextEditingController(text: authProvider.user!.phone!.isNotEmpty?authProvider.user!.phone:"");
     final confirmPasswordController=TextEditingController();
    originalName = authProvider.user?.userMetadata?['full_name']?.toString() ?? '';

    originalEmail = authProvider.user?.email ?? '';

    originalPhone = authProvider.user?.phone ?? '';

    Future<void> submitChanges() async {
      try {
        final authService = AuthService();
        final authProvider = context.read<AuthProvider>();

        User? updatedUser = authProvider.user;

        if (updatedUser == null) {
          throw Exception('User not logged in');
        }

        bool hasChanges = false;

        if (nameController.text.trim() !=
            originalName) {
          updatedUser = await authService.updateName(
            nameController.text,
          );

          hasChanges = true;
        }

        if (emailController.text.trim() !=
            originalEmail) {
          updatedUser = await authService.updateEmail(
            emailController.text,
          );

          hasChanges = true;
        }

        if (phoneController.text.trim() !=
            originalPhone) {
          updatedUser = await authService.updatePhone(
           " +2${phoneController.text}",
          );

          hasChanges = true;
        }

        if (currentPasswordController.text.isNotEmpty ||
            passwordController.text.isNotEmpty ||
            confirmPasswordController.text.isNotEmpty) {

          updatedUser = await authService.updatePasswordProfile(
            currentPassword: currentPasswordController.text,
            newPassword: passwordController.text,
            confirmPassword: confirmPasswordController.text,
          );

          hasChanges = true;
        }

        if (hasChanges) {
          authProvider.changeUser(updatedUser);

          if (!mounted) return;

          showAuthDialog(context, message: 'Profile updated successfully',
            );
        }

      } catch (e) {
        if (!mounted) return;
        showAuthDialog(context, message: e.toString());


      }
    }
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        scrolledUnderElevation: 0,


        title: Text("Edit profile") ,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 30),

            child: Form(
              key: _formKey,

              child: Column(
                spacing: 20,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                CircleAvatar(
                backgroundColor: Colors.white,
                radius: 50,
                child: Icon(Icons.person,size: 80,color: Colors.brown,),
              ),

              Text("${authProvider!.user!.userMetadata?['full_name']!.toString().trim()}",style: TextStyle(
                  fontSize: 30
              ),),
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: Color(0xffEBDEC7),
                        borderRadius: BorderRadius.circular(20)


                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("@${authProvider!.user!.userMetadata?['full_name']!.toString().trim()}.traveler",style: TextStyle(color: Colors.brown),),
                        SizedBox(
                          width: 8,
                        ),
                        Icon(Icons.location_on_sharp,color: Colors.brown,),
                        Text("Cairo,Egypt",style: TextStyle(color: Colors.brown),)
                      ],
                    ),
                  ),

                  Container(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                    color: Colors.white,
                      borderRadius: BorderRadius.circular(25)

                  ),
                    child: Column(
                      spacing: 10,
                      children: [
                        Row(
                          spacing: 10,
                          children: [
                            CircleAvatar(
                              backgroundColor: AppColors.backgroundColor,

                              child: Icon(Icons.credit_card,color:Colors.brown,),
                            ),
                            Text("Personal information",style: TextStyle(fontSize: 20),),
                          ],
                        ),
                        EditProfileInput(text: "Full name", prefixIcon: Icons.person, hintText:"",controller:nameController,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please enter your name';
                            }

                            return null;
                          },
                        ),
                        EditProfileInput(text: "Email address", prefixIcon: Icons.email, hintText:"",controller: emailController,validator: (value) {
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
                        EditProfileInput(text: "Phone number", prefixIcon: Icons.phone, hintText:"ex:01*********",controller: phoneController,),


                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25)

                    ),
                    child: Column(
                      spacing: 10,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 10,
                          children: [
                            CircleAvatar(
                              backgroundColor: AppColors.backgroundColor,

                              child: Icon(Icons.lock_reset_outlined,color:Colors.brown,),
                            ),
                            Column(
                              spacing: 5,
                                crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Security & Password",style: TextStyle(fontSize: 20),),
                                Text("Leave blank if you do not want to update\nyour password.")
                              ],
                            ),
                          ],
                        ),
                        EditProfileInput(text: "Current password", prefixIcon: Icons.lock,controller: currentPasswordController,hintText:"..........",suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              passwordObscureText = !passwordObscureText;
                            });
                          },
                          icon: Icon(
                            passwordObscureText ? Icons.visibility_off : Icons.visibility,
                          ),
                        ),
                        ),
                        EditProfileInput(text: "New password", prefixIcon: Icons.key, hintText:"Enter new password", controller: passwordController,validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a password';
                          }

                          return null;
                        }
                            ,suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              newPasswordObscureText = !newPasswordObscureText;
                            });
                          },
                          icon: Icon(
                            newPasswordObscureText ? Icons.visibility_off : Icons.visibility,
                          ),
                        ),
                        ),
                        EditProfileInput(text: "Confirm new password", controller: confirmPasswordController,prefixIcon: Icons.check_box_outlined, hintText:"Re-enter new password,",  validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please confirm your password';
                          }

                          if (value != passwordController.text) {
                            return 'Passwords do not match';
                          }

                          return null;
                        }
                            ,suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              confirmNewPasswordObscureText = !confirmNewPasswordObscureText;
                            });
                          },
                          icon: Icon(
                            confirmNewPasswordObscureText ? Icons.visibility_off : Icons.visibility,
                          ),
                        ),
                        ),


                      ],
                    ),
                  ),

                  Row(
                    spacing: 25,
                    children: [
                      Icon(Icons.shield,color: Colors.brown,),
                      Text("Your personal data is encrypted and secure\nwith PickMe Egypt.",textAlign: TextAlign.center,)
                    ],
                  ),

                  AuthButton(
                      onPressed: (){
                        submitChanges();
                      },

                      text: "Save changes",
                      color: AppColors.primary,
                    icon: Icons.check,
                  ),

                  AuthButton(
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ProfileScreen(),
                        ),
                      );
                    },

                    text: "Discard changes",
                    color: Color(0xffFFEAD7),
                  ),







                ]

              ),
            ),
          ),
        ),
      ),
    );
  }
}
