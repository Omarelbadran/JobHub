import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_hub_app/main_views/home_view/widgets/popular_job_list_view.dart';
import 'package:job_hub_app/main_views/home_view/widgets/recently_job_list.dart';
import 'package:job_hub_app/main_views/home_view/widgets/search_text_field.dart';
import 'package:job_hub_app/main_views/show_job_view/show_job_view.dart';
import '../../../cubits/drawer_menu_cubit/drawer_menu_cubit.dart';
import '../../../cubits/get_all_jobs_cubit/get_all_jobs_cubit.dart';
import '../../add_job_view/add_job_view.dart';
import 'home_app_bar.dart';

class HomeBodyContent extends StatelessWidget {
  const HomeBodyContent({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    return BlocProvider(
        create: (context) => GetAllJobsCubit()..getJobs(),
    child:  SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        child: Builder(
          builder: (innerContext) {
            return BlocBuilder<GetAllJobsCubit, GetAllJobsState>(
              builder: (context, state) {
                final GetAllJobsCubit cubit = context
                    .read<GetAllJobsCubit>();
                if (state is GetAllJobsLoading) {
                  return Center(child: CircularProgressIndicator());
                }
                if (state is GetAllJobsFailure) {
                  return Center(child: Text(state.error));
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HomeAppBar(title: 'Home',),
                    SizedBox(height: screenHeight * .02),
                    Text(
                      'Search,\nFind and Apply',
                      style: TextStyle(
                        fontSize: 30.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: screenHeight * .02),
                    Row(
                      children: [
                        SearchTextField(),
                      ],
                    ),
                    SizedBox(height: screenHeight * .02),
                    Row(
                      children: [
                        Text(
                          'Popular Jobs',
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => ShowJobView(),
                              ),
                            );
                          },
                          child: Text(
                            'View all',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepOrange,
                            ),
                          ),
                        ),
                      ],
                    ),
                    PopularJobListView(jobs: cubit.jobs),
                    SizedBox(height: screenHeight * .01),
                    Row(
                      children: [
                        Text(
                          'Recently Reposted',
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => ShowJobView(),
                              ),
                            );
                          },
                          child: Text(
                            'View all',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepOrange,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: RecentlyJobList(jobs: cubit.recentJobs),
                    ),
                  ],
                );
              },
            );
          }
        ),
      ),
    ),
);
  }
}