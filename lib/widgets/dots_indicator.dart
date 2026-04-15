import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class DotsIndicator extends StatelessWidget {
  final int currentIndex;
  final int dotsCount;

  const DotsIndicator({
    super.key,
    required this.currentIndex,
    required this.dotsCount,
  });
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children:
        List.generate(
          dotsCount,
              (index) => AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            margin: EdgeInsets.symmetric(horizontal: 4.w),
            width: currentIndex == index ? 18.w : 8.w,
            height: 8.h,
            decoration: BoxDecoration(
              color: currentIndex == index
                  ? Colors.white
                  : Colors.white.withValues(alpha: .4),
              borderRadius: BorderRadius.circular(20.r),
            ),
          ),
        ),
    );
  }
}
