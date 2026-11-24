import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pick_me/core/theme/app_colors.dart';
import 'package:pick_me/core/widgets/auth_button.dart';

class AdminProfile extends StatelessWidget {
  const AdminProfile({super.key});

  @override
  Widget build(BuildContext context) {
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
                      child: Icon(Icons.person),
                      radius: 60,

                    ),
                  Text("Sulaf amer",style: TextStyle(fontSize: 25,fontWeight: .bold)),
                  AuthButton(onPressed:(){}, text:"Edit profile info", color: Color(0xffEBDEC7))
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
                  Column(
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
                  )
                   ],
              ),
            ),

            AuthButton(onPressed:(){}, text: "Log Out of Admin Console", color:Color(0xffFFDAD6),icon: Icons.logout,textColor: Color(0xff93000A),)

          ],
        ),
      ),
    );
  }
}
