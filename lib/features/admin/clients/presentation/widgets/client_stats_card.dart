import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ClientStatsCard extends StatelessWidget {
  final int tripsCompleted;
  final String totalSpent;

  const ClientStatsCard({
    super.key,
    required this.tripsCompleted,
    required this.totalSpent,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildStat(
            value: tripsCompleted.toString(),
            label: 'Trips Completed',
            highlight: false,
          ),
        ),

        SizedBox(width: 10.w),

        Expanded(
          child: _buildStat(
            value: totalSpent,
            label: 'Total EGP',
            highlight: true,
          ),
        ),
      ],
    );
  }

  Widget _buildStat({
    required String value,
    required String label,
    required bool highlight,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30.r),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
              color: highlight
                  ? const Color(0xFF777000)
                  : const Color(0xFF302B20),
            ),
          ),
          SizedBox(height: 3.h),
          Text(
            label,
            style: TextStyle(
              fontSize: 11.sp,
              color: const Color(0xFF77736B),
            ),
          ),
        ],
      ),
    );
  }
}