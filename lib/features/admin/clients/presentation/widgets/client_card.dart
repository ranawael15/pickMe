
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ClientCard extends StatelessWidget {
  final String name;
  final String email;
  final String imageUrl;
  final int bookedTrips;
  final String totalSpent;
  final VoidCallback? onViewDetails;

  const ClientCard({
    super.key,
    required this.name,
    required this.email,
    required this.imageUrl,
    required this.bookedTrips,
    required this.totalSpent,
    this.onViewDetails,
  });

  static const Color primaryColor = Color(0xFFF5DD69);
  static const Color darkColor = Color(0xFF302B20);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.035),
            blurRadius: 12.r,
            offset: Offset(0, 4.h),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  CircleAvatar(
                    radius: 25.r,
                    backgroundColor: const Color(0xFFF3EBDD),
                    backgroundImage:
                    imageUrl.isNotEmpty ? NetworkImage(imageUrl) : null,
                    child: imageUrl.isEmpty
                        ? Icon(
                      Icons.person,
                      color: Colors.grey,
                      size: 27.sp,
                    )
                        : null,
                  ),
                  Positioned(
                    bottom: 0,
                    right: -2.w,
                    child: Container(
                      width: 13.w,
                      height: 13.w,
                      decoration: BoxDecoration(
                        color: const Color(0xFF777500),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white,
                          width: 1.5.w,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w700,
                        color: darkColor,
                      ),
                    ),
                    SizedBox(height: 3.h),
                    Text(
                      email,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 10.sp,
                        color: const Color(0xFF817D75),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Container(
            height: 50.h,
            padding: EdgeInsets.symmetric(horizontal: 9.w),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF1E4),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.card_travel_outlined,
                  size: 15.sp,
                  color: const Color(0xFF777000),
                ),
                SizedBox(width: 5.w),
                Expanded(
                  child: Text(
                    '$bookedTrips Booked Trips',
                    style: TextStyle(
                      fontSize: 11.sp,
                      color: darkColor,
                    ),
                  ),
                ),
                Container(
                  width: 4.w,
                  height: 10.w,
                  decoration: const BoxDecoration(
                    color: Color(0xFF77736B),
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: 9.w),
                Icon(
                  Icons.payments_outlined,
                  size: 15.sp,
                  color: const Color(0xFF777000),
                ),
                SizedBox(width: 4.w),
                Text(
                  '$totalSpent EGP',
                  style: TextStyle(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w600,
                    color: darkColor,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 12.h),
          SizedBox(
            width: double.infinity,
            height: 40.h,
            child: ElevatedButton(
              onPressed: onViewDetails,
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                foregroundColor: const Color(0xFF74620B),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.r),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'View Details',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(width: 5.w),
                  Icon(Icons.arrow_forward, size: 15.sp),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
