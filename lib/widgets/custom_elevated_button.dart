import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class CustomElevatedButton extends StatelessWidget {
  final void Function()? onPressed;
  final String butName;
  const CustomElevatedButton({
    super.key,
    this.onPressed,
    required this.butName
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style:ElevatedButton.styleFrom(
        backgroundColor: Colors.deepOrange.withValues(alpha: .9),
        fixedSize: Size(350.w, 40.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(2.r),
        ),
      ) ,
        onPressed:onPressed,
        child: Text(
          butName ,
          style:TextStyle(
            fontSize: 14.sp,
            color: Colors.white
          ),
        )
    );
  }
}
