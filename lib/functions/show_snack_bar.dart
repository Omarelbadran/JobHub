import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void showCustomSnackBar(BuildContext context, String content) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      margin: EdgeInsets.only(
        bottom: 40.h,
        left: 40.w,
        right: 40.w,
      ),
      content: Text(content, textAlign: TextAlign.center),
      behavior: SnackBarBehavior.floating,
      duration: const Duration(milliseconds: 1500),
    ),
  );
}