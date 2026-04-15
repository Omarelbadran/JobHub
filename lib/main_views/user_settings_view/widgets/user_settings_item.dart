import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserSettingItem extends StatelessWidget {
  final String title;
  final String subTitle;
  final IconData icon;
  final void Function()? onTap;
  const UserSettingItem({
    super.key,
    required this.title,
    required this.subTitle,
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title ,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(subTitle ,
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.black.withValues(alpha: .4),
                ),
              )
            ],
          ),
          Icon(icon , size: 20.r,color: Colors.black.withValues(alpha: .4),)
        ],
      ),
    );
  }
}
