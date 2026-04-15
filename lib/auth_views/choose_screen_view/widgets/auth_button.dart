import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class AuthButton extends StatelessWidget {
  final void Function()? onPressed;
  final String butName;
  final Color? buttonColor;
  final Color? textColor;
  const AuthButton({
    super.key,
    this.onPressed,
    required this.butName,
    this.buttonColor,
    this.textColor
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        fixedSize: Size(150.w, 50.h),
        backgroundColor: buttonColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(2.r),
          side: BorderSide(
            color: Colors.white,
            width: 1.w,
          ),
        ),
      ),
        onPressed: onPressed, 
        child: Text(butName ,
          style: TextStyle(
            fontSize: 20.sp,
            color: textColor
          ) ,)
    );
  }
}
