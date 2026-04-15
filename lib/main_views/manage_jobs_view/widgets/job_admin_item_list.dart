import 'package:flutter/material.dart';

import '../../../models/job_model/job_model.dart';
import 'job_admin_item.dart';
class JobAdminItemList extends StatelessWidget {
  final List<JobModel> jobs;
  const JobAdminItemList({
    super.key,
    required this.jobs,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: jobs.length,
      itemBuilder: (context, index) {
        return JobAdminItem(job: jobs[index],);
      },
    );
  }
}