import 'package:job_hub_app/models/job_model/job_model.dart';

class GetAllBookmarksResponse {
  final bool status;
  final List<BookmarkItem> bookmarks;

  GetAllBookmarksResponse({
    required this.status,
    required this.bookmarks,
  });

  factory GetAllBookmarksResponse.fromJson(Map<String, dynamic> json) {
    return GetAllBookmarksResponse(
      status: json['status'] ?? false,
      bookmarks: json['bookmarks'] != null
          ? (json['bookmarks'] as List)
          .map((e) {

        if (e == null || e is! Map<String, dynamic>) return null;
        return BookmarkItem.fromJson(e);
      })
          .whereType<BookmarkItem>()
          .where((item) => item.job != null)
          .toList()
          : [],
    );
  }
}

class BookmarkItem {
  final String bookmarkId;
  final JobModel? job;

  BookmarkItem({
    required this.bookmarkId,
     this.job,
  });

  factory BookmarkItem.fromJson(Map<String, dynamic> json) {
    return BookmarkItem(
      bookmarkId: json['_id'],
      job: (json['job'] != null && json['job'] is Map<String, dynamic>)
          ? JobModel.fromJson(json['job'])
          : null,
    );
  }
}