import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../../cubits/get_all_jobs_cubit/get_all_jobs_cubit.dart';
import '../../../models/job_model/job_model.dart';
import '../../update_job_view/update_job_view.dart';

class JobAdminItem extends StatelessWidget {
  final JobModel job;

  const JobAdminItem({super.key, required this.job});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Slidable(
        key:  ValueKey(job.id),

        startActionPane: ActionPane(
          extentRatio: 0.5,
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (context) {
                context.read<GetAllJobsCubit>().deleteJob(job.id);
              },
              backgroundColor: const Color(0xFFF05A2D),
              foregroundColor: Colors.white,
              icon: Icons.delete_outline,
              label: 'Delete',
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15.r),
                bottomLeft: Radius.circular(15.r),
              ),
            ),
            SlidableAction(
              onPressed: (context) async {

                final updatedJob = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => UpdateJobView(job: job)),
                );

                if (updatedJob != null && updatedJob is JobModel) {
                  if (context.mounted) {
                    context.read<GetAllJobsCubit>().updateSingleJobLocally(updatedJob);
                  }
                }
              },
              backgroundColor: const Color(0xFF3B67E1),
              foregroundColor: Colors.white,
              icon: Icons.edit_outlined,
              label: 'Update',
            ),
          ],
        ),
        child: Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: const Color(0xFFE0E0E0),
            borderRadius: BorderRadius.circular(15.r),
          ),
          child: Row(
            children: [
              Container(
                width: 55.w,
                height: 55.w,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: ClipOval(
                  child: Image.network(
                    job.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      job.title,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                        job.location,
                        style: TextStyle(fontSize: 14.sp)),
                    Text(
                      job.salary,
                      style: TextStyle(fontSize: 12.sp, color: Colors.grey[700]),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(4.w),
                decoration: const BoxDecoration(
                  color: Color(0xFFF05A2D),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.arrow_forward_ios, color: Colors.white, size: 12.sp),
              ),
            ],
          ),
        ),
      ),
    );
  }
}