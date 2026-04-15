import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_hub_app/models/job_model/job_model.dart';
class RecentlyJobCard extends StatelessWidget {
  final JobModel job;
  const RecentlyJobCard({super.key, required this.job});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      width: 220.w,
      margin:  EdgeInsets.symmetric(horizontal: 5.w , vertical: 10.h),
      padding:  EdgeInsets.symmetric(horizontal: 10.w , vertical: 20.h),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: .2),
        borderRadius: BorderRadius.circular(25.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 30.w,
                height: 20.h,
                color: Colors.white,
                child: Image.network(job.imageUrl, fit: BoxFit.fill,),
              ),
              SizedBox(width:screenWidth *.05 ),
              Expanded(
                child: Text(
                  job.company,
                  style: TextStyle(
                    overflow: TextOverflow.ellipsis,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.sp,
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: screenHeight *.01),
          Text(
            job.title,
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(height: screenHeight *.001),
          Text(
            job.location,
            style: TextStyle(
              color: Colors.black.withValues(alpha: .3),
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: screenHeight *.01),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  job.salary,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              CircleAvatar(
                radius: 16.r,
                backgroundColor: Colors.purple.shade100,
                child:  Icon(Icons.arrow_forward_ios, size: 20.sp),
              )
            ],
          )
        ],
      ),
    );
  }
}
