import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'client_form_field.dart';

class ClientPersonalInfo extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final TextEditingController cityController;
  final VoidCallback? onCityTap;

  const ClientPersonalInfo({
    super.key,
    required this.nameController,
    required this.emailController,
    required this.phoneController,
    required this.cityController,
    this.onCityTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(18.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(27.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.assignment_ind_outlined,
                color: const Color(0xFF777000),
                size: 21.sp,
              ),
              SizedBox(width: 7.w),
              Text(
                'Personal Information',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF302B20),
                ),
              ),
            ],
          ),

          SizedBox(height: 17.h),

          ClientFormField(
            label: 'Client Full Name *',
            hintText: 'Sarah Mansour',
            icon: Icons.person_outline,
            controller: nameController,
          ),

          SizedBox(height: 17.h),

          ClientFormField(
            label: 'Email Address *',
            hintText: 'sarah.mansour@example.com',
            icon: Icons.mail_outline,
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
          ),

          SizedBox(height: 17.h),

          ClientFormField(
            label: 'Phone Number',
            hintText: '+20 102 345 6789',
            icon: Icons.phone_outlined,
            controller: phoneController,
            keyboardType: TextInputType.phone,
          ),

          SizedBox(height: 17.h),

          Text(
            'Home City / Gateway',
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
              controller: cityController,
              readOnly: true,
              onTap: onCityTap,
              style: TextStyle(
                fontSize: 14.sp,
                color: const Color(0xFF302B20),
              ),
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.location_on_outlined,
                  size: 20.sp,
                  color: const Color(0xFF8C8375),
                ),
                suffixIcon: Icon(
                  Icons.keyboard_arrow_down,
                  size: 21.sp,
                  color: const Color(0xFF82796E),
                ),
                hintText: 'Cairo, Egypt',
                hintStyle: TextStyle(
                  fontSize: 14.sp,
                  color: const Color(0xFF82796E),
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                  vertical: 16.h,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}