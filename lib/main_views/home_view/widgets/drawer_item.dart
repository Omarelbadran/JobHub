import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DrawerItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const DrawerItem({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 15.h),
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.white : Colors.white60,
              size: 24.sp,
            ),
            SizedBox(width: 15.w),
            Text(
              title,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.white60,
                fontSize: 18.sp,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}