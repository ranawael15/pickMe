import 'package:flutter/material.dart';
import 'package:pick_me/core/theme/app_colors.dart';
import 'package:pick_me/features/auth/logic/provider/auth_provider.dart';
import 'package:pick_me/features/profile/presentation/widgets/edit_profile_input.dart';
import 'package:provider/provider.dart';

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




  @override
  Widget build(BuildContext context) {
    final authProvider=Provider.of<AuthProvider>(context);

    late final nameController = TextEditingController(text:"${authProvider.user!.userMetadata?['full_name']!.toString().trim()}");

    final emailController = TextEditingController(text: authProvider.user!.email);

    final passwordController = TextEditingController();
    final currentPasswordController = TextEditingController();


    final phoneController = TextEditingController(text: authProvider.user!.phone!.isNotEmpty?authProvider.user!.phone:"enter your phone number");

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
                        EditProfileInput(text: "Full name", prefixIcon: Icons.person, hintText:"",controller:nameController,),
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
                        EditProfileInput(text: "Phone number", prefixIcon: Icons.phone, hintText:"",controller: phoneController,),


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
                        EditProfileInput(text: "Confirm new password", prefixIcon: Icons.check_box_outlined, hintText:"Re-enter new password,",  validator: (value) {
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

                  SizedBox(
                    width: double.infinity,
                    child: MaterialButton(
                      color: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      onPressed:(){},
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.check),

                            Text(
                              // isLoading ? "Signing In..." : "Sign In to PickMe ",
                              "Save changes"
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: MaterialButton(
                      color: Color(0xffFFEAD7),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      onPressed:(){},
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            Text(
                              // isLoading ? "Signing In..." : "Sign In to PickMe ",
                                "Discard changes"
                            ),
                          ],
                        ),
                      ),
                    ),
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
