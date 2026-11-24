import 'package:flutter/material.dart';
import 'package:pick_me/core/theme/app_colors.dart';
import 'package:pick_me/core/utils/auth_dialog.dart';
import 'package:pick_me/features/auth/logic/provider/auth_provider.dart';
import 'package:pick_me/features/auth/services/auth_service.dart';
import 'package:pick_me/features/profile/presentation/widgets/profile_navigator.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {

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
    final authProvider=Provider.of<AuthProvider>(context);

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        title: Text("Back to home"),

      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          spacing: 20,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: Colors.white,
              radius: 50,
              child: Icon(Icons.person,size: 80,color: Colors.brown,),
            ),

            Text("${authProvider.user!.userMetadata?['full_name']!.toString().trim()}",style: TextStyle(
              fontSize: 30,
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
                  Text("@${authProvider.user!.userMetadata?['full_name']!.toString().trim()}.traveler",style: TextStyle(
                    color: Colors.brown
                  ),),
                  SizedBox(
                    width: 8,
                  ),
                  Icon(Icons.location_on_sharp,color: Colors.brown,),
                  Text("Cairo,Egypt",style: TextStyle(
                      color: Colors.brown

                  ),)
                ],
              ),
            ),
            ProfileNavigator(
              title: "Trip history",
              subtitle: "View your previous trips & adventures",
              icon: Icons.history,
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  "/trip_history",
                );
              },
            ),
            ProfileNavigator(
              title: "Edit profile",
              subtitle: "Update your personal information",
              icon: Icons.edit,
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  "/edit_profile",
                );
              },
            ),

            SizedBox(
              width: double.infinity,
              child: MaterialButton(
                color: Color(0xffFFDAD6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                onPressed: handleLogout,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    spacing: 5,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.exit_to_app,color:Color(0xff93000A)),
                      Text(
                       "Log out",
                        style: TextStyle(
                          color: Color(0xff93000A)
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),




          ],
        ),
      ),
    );
  }
}
