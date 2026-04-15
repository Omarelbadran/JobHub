import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class CustomAppBar extends StatelessWidget {
  final String title;
  const CustomAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: 30.h,
          width: 30.w,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              border:Border.all(
                  color: Colors.black,
                  width: 1.5.r
              )
          ),
          child: Icon(Icons.list_sharp),
        ),
        Text(title,
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight:FontWeight.bold,
        ),
        ),
        Container(
          height: 35.h,
          width: 35.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
          child: Image.asset('assets/images/user.png'),
        ),
      ],
    );
  }
}
