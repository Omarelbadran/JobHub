import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_hub_app/main_views/show_job_view/widgets/show_job_card.dart';
import 'package:job_hub_app/models/job_model/job_model.dart';

import '../../job_view/job_view.dart';
class ShowJobList extends StatelessWidget {
  final List<JobModel> jobs;
  const ShowJobList({super.key , required this.jobs });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: jobs.length,
      itemBuilder: (context, index) {
        final job = jobs[index];
        return  GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => JobView(job: job),
                ),
              );
            },
            child: ShowJobCard(job: job,));
      },
    );
  }
}
