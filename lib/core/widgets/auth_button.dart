import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pick_me/core/theme/app_colors.dart';

class AuthButton extends StatelessWidget {
  Color? color;
  Color? textColor;

  IconData? icon;
  String text;
  void Function()? onPressed;
   AuthButton({super.key,required this.onPressed,required this.text,required this.color,this.icon,this.textColor});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: MaterialButton(
        color:color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        onPressed:onPressed,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            spacing: 7,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon!=null? Icon(icon,color: textColor,):Container(),

              Text(
                  text,
                style: TextStyle(
                  color: textColor
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
