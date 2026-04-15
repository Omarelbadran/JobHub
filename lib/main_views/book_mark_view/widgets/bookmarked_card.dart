import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../models/get_all_bookmarks/get_all_bookmarks_response.dart';
class BookmarkedCard extends StatelessWidget {
  final BookmarkItem bookmarkedJob;
  const BookmarkedCard({super.key , required this.bookmarkedJob});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: 220.w,
      height: 90.h,
      margin:  EdgeInsets.symmetric(horizontal: 5.w , vertical: 10.h),
      padding:  EdgeInsets.symmetric(horizontal: 10.w , vertical: 5.h),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: .2),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child:Row(
          children: [
            Container(
              width: 50.w,
              height: 50.h,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(50.r),
                  child: Image.network(bookmarkedJob.job!.imageUrl , fit: BoxFit.fill,)),
            ),
            SizedBox(width: screenWidth * .02 ,),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(bookmarkedJob.job!.title,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(bookmarkedJob.job!.company,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: screenHeight * .01 ,),
                Text(bookmarkedJob.job!.salary,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.sp,
                  ),
                ),
              ],
            ),
            Spacer(),
            CircleAvatar(
              radius: 16.r,
              backgroundColor: Colors.deepOrange,
              child: const Icon(Icons.arrow_forward_ios, size: 24 , color: Colors.white,),
            ),
          ]
      ) ,
    );
  }
}
