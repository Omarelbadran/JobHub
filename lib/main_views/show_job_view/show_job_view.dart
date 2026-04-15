import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_hub_app/main_views/show_job_view/widgets/show_job_list.dart';

import '../../cubits/get_all_jobs_cubit/get_all_jobs_cubit.dart';

class ShowJobView extends StatelessWidget {
  const ShowJobView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      GetAllJobsCubit()
        ..getJobs(),
      child: Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back)),
          title: Text('Jobs',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.sp
            ),
          ),
          centerTitle: true,
        ),
        body: BlocBuilder<GetAllJobsCubit, GetAllJobsState>(
          builder: (context, state) {
            final GetAllJobsCubit cubit = context.read<GetAllJobsCubit>();
            if (state is GetAllJobsLoading) {
              return Center(child: CircularProgressIndicator());
            }
            if (state is GetAllJobsFailure) {
              return Center(child: Text(state.error));
            }
            return ShowJobList(jobs: cubit.jobs ,);
          },
        ),
      ),
    );
  }
}
