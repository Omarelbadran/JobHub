import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class CustomTextButton extends StatelessWidget {
  final void Function()? onPressed;
  final String butName;
  const CustomTextButton({super.key, this.onPressed, required this.butName,});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
        child: Text(
          butName,
        style: TextStyle(
          fontSize: 20.sp,
          color: Colors.white
        ),
        ),
    );
  }
}
