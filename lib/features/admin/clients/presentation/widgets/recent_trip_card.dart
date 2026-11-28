import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RecentTripCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String status;
  final String price;
  final String date;
  final VoidCallback? onTap;

  const RecentTripCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.status,
    required this.price,
    required this.date,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool isConfirmed = status.toLowerCase() == 'confirmed';

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.025),
              blurRadius: 8.r,
              offset: Offset(0, 3.h),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: imageUrl.isNotEmpty
                  ? Image.network(
                imageUrl,
                width: 65.w,
                height: 65.w,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => _placeholder(),
              )
                  : _placeholder(),
            ),

            SizedBox(width: 10.w),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.w,
                          vertical: 4.h,
                        ),
                        decoration: BoxDecoration(
                          color: isConfirmed
                              ? const Color(0xFFF5DD76)
                              : const Color(0xFFEDE4D2),
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Text(
                          status,
                          style: TextStyle(
                            fontSize: 10.sp,
                            color: const Color(0xFF655A29),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),

                      const Spacer(),

                      Text(
                        price,
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF776B1E),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 6.h),

                  Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF302B20),
                      height: 1.2,
                    ),
                  ),

                  SizedBox(height: 5.h),

                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today_outlined,
                        size: 12.sp,
                        color: const Color(0xFF817D75),
                      ),
                      SizedBox(width: 4.w),
                      Expanded(
                        child: Text(
                          date,
                          style: TextStyle(
                            fontSize: 11.sp,
                            color: const Color(0xFF817D75),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _placeholder() {
    return Container(
      width: 65.w,
      height: 65.w,
      color: const Color(0xFFF3EBDD),
      child: Icon(
        Icons.image_outlined,
        color: Colors.grey,
        size: 25.sp,
      ),
    );
  }
}