import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_hub_app/main_views/show_job_view/widgets/show_job_card.dart';
import 'package:job_hub_app/models/get_all_bookmarks/get_all_bookmarks_response.dart';
import 'package:job_hub_app/models/job_model/job_model.dart';

import '../../job_view/job_view.dart';
import 'bookmarked_card.dart';
class BookmarkedList extends StatelessWidget {
  final List<BookmarkItem> bookmarkedJobs;
  const BookmarkedList({super.key , required this.bookmarkedJobs });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: bookmarkedJobs.length,
      itemBuilder: (context, index) {
        final bookmarkedJob = bookmarkedJobs[index];
        return  GestureDetector(
            onTap: () {

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => JobView(job: bookmarkedJob.job!),
                ),
              );
            },
            child: BookmarkedCard(bookmarkedJob: bookmarkedJob,));
      },
    );
  }
}
