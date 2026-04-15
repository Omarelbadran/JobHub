import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_hub_app/cubits/get_all_jobs_cubit/get_all_jobs_cubit.dart';
import 'package:job_hub_app/main_views/manage_jobs_view/widgets/job_admin_item_list.dart';
import '../add_job_view/add_job_view.dart';
import 'widgets/job_admin_item.dart';
import 'package:job_hub_app/widgets/settings_app_bar.dart';

class ManageJobsView extends StatelessWidget {
  const ManageJobsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetAllJobsCubit()..getJobs(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Column(
              children: [
                SettingsAppBar(
                  title: 'Manage Jobs',
                  onPressed: () => Navigator.pop(context),
                ),

                SizedBox(height: 10.h),

                Expanded(
                  child: BlocBuilder<GetAllJobsCubit, GetAllJobsState>(
                    builder: (context, state) {
                      if (state is GetAllJobsLoading) {
                        return const Center(
                          child: CircularProgressIndicator(color: Color(0xFFF05A2D)),
                        );
                      }

                      if (state is GetAllJobsSuccess) {
                        final jobsList = state.response.jobs;

                        return jobsList.isEmpty
                            ? const Center(child: Text("No jobs found"))
                            : JobAdminItemList(jobs: jobsList);
                      }
                      return const Center(child: Text("Something went wrong"));
                    },
                  ),
                ),
              ],
            ),
          ),
        ),

        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddJobView(),
              ),
            ).then((value) {
              if (context.mounted) {
                context.read<GetAllJobsCubit>().getJobs();
              }
            });
          },
          backgroundColor: const Color(0xFFF05A2D),
          shape: const CircleBorder(),
          child: const Icon(Icons.add, color: Colors.white, size: 30),
        ),
      ),
    );
  }
}
