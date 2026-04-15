import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_hub_app/models/job_model/job_model.dart';
class JobSummaryCard extends StatelessWidget {
  final JobModel job;
  const JobSummaryCard({super.key , required this.job});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: 320.w,
      height: 150.h,
      padding:  EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: .2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 35.w,
            height: 35.h,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50.r),
              child: Image.network(job.imageUrl , fit: BoxFit.fill,),
          ),
          ),
          Text(job.title ,
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
          ),
          Text(job.location ,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black.withValues(alpha: .3),
            ),
          ),
          SizedBox(height: screenHeight * .025 , ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.deepOrange,
                    width: 1.w,
                  ),
                  color: Colors.white,
                ),
                width: 90.w,
                height: 25.h,
                child: Center(
                  child: Text(job.workHours ,
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.deepOrange
                  ),
                  ),
                ),
              ),
              SizedBox(width: screenWidth * .04 , ),
              Text(job.salary ,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
              )
            ],
          )
        ],
      ),
    );
  }
}
