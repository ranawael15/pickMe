import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ClientProfileHeader extends StatelessWidget {
  final String name;
  final String email;
  final String imageUrl;
  final String joinDate;
  final String city;

  const ClientProfileHeader({
    super.key,
    required this.name,
    required this.email,
    required this.imageUrl,
    required this.joinDate,
    required this.city,
  });

  @override
  Widget build(BuildContext context) {
    const darkColor = Color(0xFF302B20);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 18.h,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28.r),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(3.w),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: const Color(0xFFF1DC75),
                width: 2.5.w,
              ),
            ),
            child: CircleAvatar(
              radius: 50.r,
              backgroundColor: const Color(0xFFF5EBDD),
              backgroundImage: imageUrl.isNotEmpty
                  ? NetworkImage(imageUrl)
                  : null,
              child: imageUrl.isEmpty
                  ? Icon(
                Icons.person,
                size: 45.sp,
                color: Colors.grey,
              )
                  : null,
            ),
          ),

          SizedBox(height: 12.h),

          Text(
            name,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
              color: darkColor,
            ),
          ),

          SizedBox(height: 5.h),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.email_outlined,
                size: 15.sp,
                color: const Color(0xFF77736B),
              ),
              SizedBox(width: 5.w),
              Flexible(
                child: Text(
                  email,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: const Color(0xFF77736B),
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 6.h),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.calendar_today_outlined,
                size: 14.sp,
                color: const Color(0xFF77736B),
              ),
              SizedBox(width: 5.w),
              Flexible(
                child: Text(
                  'Joined $joinDate • $city',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: const Color(0xFF77736B),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}