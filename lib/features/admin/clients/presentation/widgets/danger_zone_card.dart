import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DangerZoneCard extends StatelessWidget {
  final VoidCallback? onDelete;

  const DangerZoneCard({
    super.key,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(17.w),
      decoration: BoxDecoration(
        color: const Color(0xFFFFDADA),
        borderRadius: BorderRadius.circular(28.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.warning_amber_rounded,
                color: const Color(0xFF951D2B),
                size: 21.sp,
              ),
              SizedBox(width: 5.w),
              Text(
                'Danger Zone',
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF951D2B),
                ),
              ),
            ],
          ),

          SizedBox(height: 9.h),

          Text(
            'Permanently remove client account from PickMe. This action cannot be reversed.',
            style: TextStyle(
              fontSize: 12.sp,
              height: 1.5,
              color: const Color(0xFF8F2631),
            ),
          ),

          SizedBox(height: 14.h),

          SizedBox(
            width: double.infinity,
            height: 48.h,
            child: ElevatedButton(
              onPressed: onDelete,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: const Color(0xFFA52B35),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.r),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.delete_outline,
                    size: 19.sp,
                  ),
                  SizedBox(width: 6.w),
                  Text(
                    'Delete Client Account',
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}