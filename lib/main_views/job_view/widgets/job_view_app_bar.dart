import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class JobAppBar extends StatelessWidget {
  final String title;
  final void Function()? onPressed;
  final bool isBookmarked;
  final void Function()? onBookmarkTap;

  const JobAppBar({
    super.key,
    required this.title,
    this.onPressed,
    required this.isBookmarked,
    this.onBookmarkTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: onPressed,
          icon: Icon(Icons.arrow_back, color: Colors.black),
        ),
        Text(
          title,
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
        ),
        IconButton(
          onPressed: onBookmarkTap,
          icon: Icon(
            isBookmarked ? Icons.bookmark : Icons.bookmark_border,
            color: isBookmarked ? Colors.deepOrange : Colors.black,
          ),
        ),
      ],
    );
  }
}
