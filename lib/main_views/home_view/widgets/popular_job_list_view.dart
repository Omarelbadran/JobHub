import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_hub_app/main_views/home_view/widgets/popular_job_card.dart';

import '../../../models/job_model/job_model.dart';

class PopularJobListView extends StatelessWidget {
  final List<JobModel> jobs;
  const PopularJobListView({super.key , required this.jobs});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: jobs.length,
        itemBuilder: (context, index) {
          final job = jobs[index];
          return PopularJobCard(job: job);
        },
      ),
    );
  }
}
