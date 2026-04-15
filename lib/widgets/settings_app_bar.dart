import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class SettingsAppBar extends StatelessWidget {
  final String title;
  final void Function()? onPressed;
  const SettingsAppBar({super.key,
    required this.title,
    this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: onPressed,
          icon: Icon(
          Icons.arrow_back_ios_new , color: Colors.black,),
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
