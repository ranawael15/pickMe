import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pick_me/core/theme/app_colors.dart';
import 'package:pick_me/core/utils/auth_dialog.dart';
import 'package:pick_me/core/widgets/auth_button.dart';
import 'package:pick_me/features/auth/logic/provider/auth_provider.dart';
import 'package:pick_me/features/auth/services/auth_service.dart';
import 'package:pick_me/features/profile/presentation/screens/edit_profile.dart';
import 'package:pick_me/features/profile/presentation/widgets/profile_navigator.dart';
import 'package:provider/provider.dart';

class AdminProfile extends StatefulWidget {
  const AdminProfile({super.key});

  @override
  State<AdminProfile> createState() => _AdminProfileState();
}

class _AdminProfileState extends State<AdminProfile> {
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
    final authProvider=Provider.of<AuthProvider>(context);

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        title: Text("Admin profile"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          spacing: 20,
          crossAxisAlignment: .start,
          children: [
            Container(
              padding: EdgeInsets.all(25),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25)
              ),
              child: Column(
                spacing: 10,
                crossAxisAlignment: .start,
                children: [
                  CircleAvatar(
                    backgroundColor:  AppColors.backgroundColor,
                    radius: 50,
                    child: Icon(Icons.person,size: 80,color: Colors.brown,),
                  ),
                  Text(authProvider.user!.userMetadata?['full_name']!.toString().trim()??"",style: TextStyle(fontSize: 25,fontWeight: .bold)),
                  AuthButton(onPressed:(){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const EditProfile(),
                      ),
                    );
                  }, text:"Edit profile info", color: Color(0xffEBDEC7))
                ],
              ),
            ),
            Text("Recent Activity",style: TextStyle(fontSize: 20,fontWeight: .bold)),
            Container(
              padding: EdgeInsets.all(25),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25)
              ),
              child: Row(
                spacing: 10,
                crossAxisAlignment: .start,
                children: [
                  CircleAvatar(
                    backgroundColor: AppColors.primary,
                    child: Icon(Icons.eighteen_up_rating_outlined,color: Color(0xff715E00),),

                  ),

                  Expanded(
                    child: Column(
                      spacing: 5,
                      crossAxisAlignment: .start,
                      children: [
                        Text("Approved Cairo 3-Day Luxury Itinerary template",style: TextStyle(fontSize: 20,fontWeight: .bold)),
                        Row(
                          spacing: 7,
                          children: [
                            Text("2 days ago"),
                            Icon(Icons.circle,size: 8,),
                            Text("Media catalog")
                          ],
                        )
                      ],
                    ),
                  )
                   ],
              ),
            ),

            AuthButton(onPressed:(){
              handleLogout();

            }, text: "Log Out of Admin Console", color:Color(0xffFFDAD6),icon: Icons.logout,textColor: Color(0xff93000A),)

          ],
        ),
      ),
    );




  }
}
