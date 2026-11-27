import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pick_me/core/theme/app_colors.dart';

class ProfileNavigator extends StatelessWidget {
  IconData icon;
  String title;
  String subtitle;
  void Function()? onPressed;
   ProfileNavigator({super.key,required this.title,required this.icon,required this.subtitle,required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,

      ),
      padding: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(
            backgroundColor: AppColors.backgroundColor,
            child: Icon(icon,color: Colors.black,),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Text(title,style: TextStyle(fontSize: 20,fontWeight: .bold)),
            Text(subtitle)


          ],),
          IconButton(onPressed:onPressed, icon:Icon(Icons.arrow_forward_ios))
        ],
      ),
    );
  }
}
