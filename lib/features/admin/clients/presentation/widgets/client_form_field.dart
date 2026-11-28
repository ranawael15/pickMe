import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ClientFormField extends StatelessWidget {
  final String label;
  final String hintText;
  final IconData icon;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final bool readOnly;
  final VoidCallback? onTap;

  const ClientFormField({
    super.key,
    required this.label,
    required this.hintText,
    required this.icon,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.readOnly = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF39352D),
          ),
        ),

        SizedBox(height: 7.h),

        Container(
          height: 52.h,
          decoration: BoxDecoration(
            color: const Color(0xFFFFF0E3),
            borderRadius: BorderRadius.circular(30.r),
          ),
          child: TextField(
            controller: controller,
            keyboardType: keyboardType,
            readOnly: readOnly,
            onTap: onTap,
            style: TextStyle(
              fontSize: 14.sp,
              color: const Color(0xFF302B20),
            ),
            decoration: InputDecoration(
              prefixIcon: Icon(
                icon,
                size: 20.sp,
                color: const Color(0xFF8C8375),
              ),
              hintText: hintText,
              hintStyle: TextStyle(
                fontSize: 14.sp,
                color: const Color(0xFF82796E),
              ),
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                vertical: 16.h,
              ),
            ),
          ),
        ),
      ],
    );
  }
}