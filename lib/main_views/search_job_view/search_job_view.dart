import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../cubits/serach_jobs_cubit/search_jobs_cubit.dart';

class SearchJobView extends StatelessWidget {
  const SearchJobView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchJobsCubit(),
      child: Scaffold(
        appBar: AppBar(
          actions: [
            BlocBuilder<SearchJobsCubit, SearchJobsState>(
              builder: (context, state) {
                return IconButton(
                  icon: Icon(
                    Icons.search,
                    size: 25,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    context.read<SearchJobsCubit>().toggleSearch();
                  },
                );
              },
            ),
          ],
          backgroundColor: Colors.deepOrange,
          leading: Builder(
            builder: (context) {
              return IconButton(
                icon: const Icon(
                    Icons.arrow_back_ios_new, color: Colors.white),
                onPressed: () {
                  final SearchJobsCubit cubit = context.read<SearchJobsCubit>();

                  if (cubit.isSearching) {
                    cubit.closeSearch();
                  } else {
                    Navigator.pop(context);
                  }
                },
              );
            }
          ),
          centerTitle: true,
          title: BlocBuilder<SearchJobsCubit, SearchJobsState>(
            builder: (context, state) {
              final SearchJobsCubit cubit = context.read<SearchJobsCubit>();
             return cubit.isSearching ?
             TextField(
               autofocus: true,
               style: const TextStyle(color: Colors.white),
               cursorColor: Colors.white,
               decoration: const InputDecoration(
                 hintText: 'Search...',
                 hintStyle: TextStyle(color: Colors.white70),
                 border: InputBorder.none,
               ),
               onChanged: (value) {
                 context.read<SearchJobsCubit>().searchJobs(value);
               },
             ) :
             Text(
               'SEARCH FOR A JOB',
               style: TextStyle(
                 color: Colors.white,
                 fontSize: 16.sp,
               ),
             );
            },
          ),
        ),
        body: BlocBuilder<SearchJobsCubit, SearchJobsState>(
          builder: (context, state) {
            if (state is SearchJobsLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is SearchJobsSuccess && state.jobs.isEmpty) {
              return Center(child: Text("No jobs found"));
            }
            if (state is SearchJobsSuccess) {
              return ListView.builder(
                itemCount: state.jobs.length,
                itemBuilder: (context, index) {
                  final job = state.jobs[index];

                  return ListTile(
                    title: Text(job.title ?? ''),
                    subtitle: Text(job.company ?? ''),
                  );
                },
              );
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/optimized_search.png'),
                Text('Start searching for a job',
                  style: TextStyle(
                    fontSize: 25.sp,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
