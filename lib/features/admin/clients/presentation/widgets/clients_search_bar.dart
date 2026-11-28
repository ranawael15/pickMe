import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ClientsSearchBar extends StatelessWidget {
  final ValueChanged<String>? onChanged;

  const ClientsSearchBar({
    super.key,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 46.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30.r),
      ),
      child: TextField(
        onChanged: onChanged,
        style: TextStyle(
          fontSize: 13.sp,
          color: const Color(0xFF29251D),
        ),
        decoration: InputDecoration(
          hintText: 'Search clients by name, email, or city...',
          hintStyle: TextStyle(
            fontSize: 12.sp,
            color: const Color(0xFF99958E),
          ),
          prefixIcon: Icon(
            Icons.search,
            size: 19.sp,
            color: const Color(0xFF77736B),
          ),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            vertical: 14.h,
          ),
        ),
      ),
    );
  }
}