import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class SkillItem extends StatelessWidget {
  final String skillName;
  final VoidCallback? onTap;
  const SkillItem({super.key, required this.skillName, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 340.w,
        height: 45.h,
        margin:  EdgeInsets.symmetric(horizontal: 5.w , vertical: 10.h),
        padding:  EdgeInsets.symmetric(horizontal: 10.w , vertical: 5.h),
        decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: .1),
        ),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            skillName ,
            style: TextStyle(
              fontSize: 16.sp,
            ),
          ),
        ),
      ),
    );
  }
}
