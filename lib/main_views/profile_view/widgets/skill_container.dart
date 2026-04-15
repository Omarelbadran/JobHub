import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class SkillContainer extends StatelessWidget {
  final String skillName;
  const SkillContainer({super.key,
    required this.skillName});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280.w,
      height: 45.h,
      margin:  EdgeInsets.symmetric(horizontal: 5.w , vertical: 10.h),
      padding:  EdgeInsets.symmetric(horizontal: 10.w , vertical: 5.h),
      decoration: BoxDecoration(
        color: Colors.white
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
    );
  }
}
