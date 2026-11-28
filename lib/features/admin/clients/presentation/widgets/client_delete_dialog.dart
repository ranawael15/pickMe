import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ClientDeleteDialog extends StatelessWidget {
  final VoidCallback onConfirm;

  const ClientDeleteDialog({
    super.key,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(22.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 55.w,
              height: 55.w,
              decoration: const BoxDecoration(
                color: Color(0xFFFFE2E2),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.delete_outline,
                color: const Color(0xFFA52B35),
                size: 28.sp,
              ),
            ),

            SizedBox(height: 15.h),

            Text(
              'Delete Client Account?',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 17.sp,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF302B20),
              ),
            ),

            SizedBox(height: 10.h),

            Text(
              'Are you sure you want to permanently remove this client account from PickMe? This action cannot be reversed.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12.sp,
                height: 1.5,
                color: const Color(0xFF817D75),
              ),
            ),

            SizedBox(height: 22.h),

            SizedBox(
              width: double.infinity,
              height: 45.h,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  onConfirm();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFA52B35),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                ),
                child: Text(
                  'Delete Account',
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),

            SizedBox(height: 9.h),

            SizedBox(
              width: double.infinity,
              height: 43.h,
              child: TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'Cancel',
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF6E675B),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}