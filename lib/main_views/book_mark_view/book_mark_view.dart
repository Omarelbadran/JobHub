import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_hub_app/main_views/book_mark_view/widgets/bookmarked_list.dart';

import '../../cubits/get_all_bookmarks_cubit/get_all_bookmarks_cubit.dart';
import '../../widgets/custom_app_bar.dart';
import '../home_view/widgets/home_app_bar.dart';

class BookMarkView extends StatelessWidget {
  const BookMarkView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: Column(
            children: [
              HomeAppBar(title: 'BookMarks'),
              Expanded(
                child: BlocBuilder<GetAllBookmarksCubit, GetAllBookmarksState>(
                  builder: (context, state) {
                    if (state is GetAllBookmarksLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is GetAllBookmarksSuccess) {
                      if (state.bookmarks.isEmpty) {
                        return Center(
                          child: Text(
                            "You haven't bookmarked any jobs yet",
                            style: TextStyle(fontSize: 16.sp, color: Colors.grey),
                          ),
                        );
                      }
                      return BookmarkedList(bookmarkedJobs: state.bookmarks);
                    } else if (state is GetAllBookmarksFailure) {
                      return Center(
                        child: Text(
                          state.error,
                          style: const TextStyle(color: Colors.red),
                        ),
                      );
                    }
                    return const SizedBox();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
