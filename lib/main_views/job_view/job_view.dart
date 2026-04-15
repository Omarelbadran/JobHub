import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_hub_app/cubits/add_book_mark_cubit/add_bookmark_cubit.dart';
import 'package:job_hub_app/main_views/job_view/widgets/job_summary_card.dart';
import 'package:job_hub_app/main_views/job_view/widgets/job_view_app_bar.dart';
import 'package:job_hub_app/models/job_model/job_model.dart';
import 'package:job_hub_app/widgets/custom_elevated_button.dart';

import '../../cubits/delete_bookmark_cubit/delete_bookmark_cubit.dart';
import '../../cubits/get_all_bookmarks_cubit/get_all_bookmarks_cubit.dart';
import '../../functions/show_snack_bar.dart';

class JobView extends StatelessWidget {
  final JobModel job;

  const JobView({super.key, required this.job});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AddBookmarkCubit()),
        BlocProvider(create: (context) => DeleteBookmarkCubit()),
      ],
      child: Scaffold(
        body: SafeArea(
          child: MultiBlocListener(
            listeners: [
              BlocListener<AddBookmarkCubit, AddBookmarkState>(
                listener: (context, state) {
                  if (state is AddBookmarkSuccess) {
                    showCustomSnackBar(
                      context,
                      state.response.message ?? "Added!",
                    );
                    context.read<GetAllBookmarksCubit>().getAllBookmarks();
                  } else if (state is AddBookmarkFailure) {
                    showCustomSnackBar(context, state.error);
                  }
                },
              ),
              // Listener لنجاح المسح: بنحدث الـ Cache ونظهر رسالة
              BlocListener<DeleteBookmarkCubit, DeleteBookmarkState>(
                listener: (context, state) {
                  if (state is DeleteBookmarkSuccess) {
                    showCustomSnackBar(
                      context,
                      state.response.message ?? "Removed!",
                    );
                    context.read<GetAllBookmarksCubit>().getAllBookmarks();
                  } else if (state is DeleteBookmarkFailure) {
                    showCustomSnackBar(context, state.errorMessage);
                  }
                },
              ),
            ],
            child: BlocBuilder<GetAllBookmarksCubit, GetAllBookmarksState>(
              builder: (context, state) {
                final bookmarkMap = context
                    .read<GetAllBookmarksCubit>()
                    .jobsToBookmarksMap;
                final bool isSaved = bookmarkMap.containsKey(job.id.toString());
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        JobAppBar(
                          isBookmarked: isSaved,
                          onBookmarkTap: () {
                            if (isSaved) {
                              String? bId = bookmarkMap[job.id.toString()];
                              context
                                  .read<DeleteBookmarkCubit>()
                                  .deleteBookmark(bId!);
                            } else {
                              context.read<AddBookmarkCubit>().addBookmark(
                                job.id.toString(),
                              );
                            }
                          },
                          onPressed: () => Navigator.pop(context),
                          title: job.company,
                        ),
                        SizedBox(height: screenHeight * .04),
                        Center(child: JobSummaryCard(job: job)),
                        SizedBox(height: screenHeight * .02),
                        Text(
                          'Job Description',
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: screenHeight * .01),
                        Text(
                          job.description,
                          maxLines: 3,
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.black.withValues(alpha: .3),
                          ),
                        ),
                        SizedBox(height: screenHeight * .03),
                        Text(
                          'Requirements',
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: screenHeight * .01),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: job.requirements.map((item) {
                            return Padding(
                              padding: EdgeInsets.only(bottom: 8.h),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '• ',
                                    style: TextStyle(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black54,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      item,
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        color: Colors.black.withValues(
                                          alpha: .5,
                                        ),
                                        height: 1.4,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                        SizedBox(height: screenHeight * .3),
                        CustomElevatedButton(
                          onPressed: () {},
                          butName: 'Apply Now',
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
