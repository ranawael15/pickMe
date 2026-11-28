import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/client_profile_header.dart';
import '../widgets/client_stats_card.dart';
import '../widgets/recent_trip_card.dart';
import '../widgets/danger_zone_card.dart';
import '../widgets/client_delete_dialog.dart';

class ClientDetailsScreen extends StatelessWidget {
  final String name;
  final String email;
  final String imageUrl;
  final String joinDate;
  final String city;
  final int tripsCompleted;
  final String totalSpent;

  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const ClientDetailsScreen({
    super.key,
    this.name = 'Sarah Mansour',
    this.email = 'sarah.mansour@example.com',
    this.imageUrl = '',
    this.joinDate = 'March 2024',
    this.city = 'Cairo, Egypt',
    this.tripsCompleted = 14,
    this.totalSpent = '42.8k',
    this.onEdit,
    this.onDelete,
  });

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return ClientDeleteDialog(
          onConfirm: () {
            onDelete?.call();
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    const backgroundColor = Color(0xFFFFFAF6);
    const darkColor = Color(0xFF302B20);
    const primaryColor = Color(0xFF776B1E);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20.w,
                vertical: 15.h,
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(
                      Icons.arrow_back,
                      size: 23.sp,
                      color: darkColor,
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Text(
                    'Client Details',
                    style: TextStyle(
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w700,
                      color: darkColor,
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(
                  20.w,
                  5.h,
                  20.w,
                  25.h,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClientProfileHeader(
                      name: name,
                      email: email,
                      imageUrl: imageUrl,
                      joinDate: joinDate,
                      city: city,
                    ),

                    SizedBox(height: 22.h),

                    ClientStatsCard(
                      tripsCompleted: tripsCompleted,
                      totalSpent: totalSpent,
                    ),

                    SizedBox(height: 26.h),

                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Recent Journeys',
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700,
                            color: darkColor,
                          ),
                        ),

                        TextButton(
                          onPressed: () {
                            // View all journeys later.
                          },
                          child: Text(
                            'View All ($tripsCompleted)',
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 8.h),

                    const RecentTripCard(
                      imageUrl: '',
                      title: 'Cairo: Pharaohs & Flavors',
                      status: 'Confirmed',
                      price: '3,850 EGP',
                      date: 'Nov 14 - Nov 16, 2025',
                    ),

                    SizedBox(height: 12.h),

                    const RecentTripCard(
                      imageUrl: '',
                      title: 'Alexandria Seaside & Citadel',
                      status: 'Completed',
                      price: '2,400 EGP',
                      date: 'Oct 2025',
                    ),

                    SizedBox(height: 22.h),

                    SizedBox(
                      width: double.infinity,
                      height: 52.h,
                      child: ElevatedButton(
                        onPressed: onEdit,
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                          const Color(0xFFF5DD76),
                          foregroundColor: primaryColor,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(30.r),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.info_outline,
                              size: 20.sp,
                            ),
                            SizedBox(width: 7.w),
                            Text(
                              'Client Information',
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 22.h),

                    DangerZoneCard(
                      onDelete: () {
                        _showDeleteDialog(context);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}