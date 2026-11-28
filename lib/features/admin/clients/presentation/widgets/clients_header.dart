import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ClientsHeader extends StatelessWidget {
  const ClientsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Clients',
          style: TextStyle(
            fontSize: 22.sp,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF29251D),
            height: 1.2,
          ),
        ),

        SizedBox(height: 5.h),

        Text(
          'Manage registered travelers, account status, and bookings across Egypt.',
          style: TextStyle(
            fontSize: 11.sp,
            fontWeight: FontWeight.w400,
            color: const Color(0xFF77736B),
            height: 1.5,
          ),
        ),
      ],
    );
  }
}