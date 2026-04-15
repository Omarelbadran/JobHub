import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class ChatAppBar extends StatelessWidget {
  final String title;
  final String userImage;
  final void Function()? onPressed;
  const ChatAppBar({super.key,
    required this.title,
    this.onPressed,
    required this.userImage});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: onPressed,
          icon: Icon(
            Icons.arrow_back , color: Colors.black,),
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
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.r),
            child: (userImage.startsWith('http'))
                ? Image.network(
              userImage,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
                  Image.asset('assets/images/user.png'),
            )
                : Image.asset('assets/images/user.png'),
          ),
        ),
      ],
    );
  }
}
