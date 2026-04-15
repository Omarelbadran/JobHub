import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class ItemContainer extends StatelessWidget {
  final double width;
  final double height;
  final Widget child;
  const ItemContainer({super.key,
    required this.width,
    required this.height,
    required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin:  EdgeInsets.symmetric(horizontal: 5.w , vertical: 10.h),
      padding:  EdgeInsets.symmetric(horizontal: 10.w , vertical: 5.h),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: .2),
      ),
      child: child,
    );
  }
}
