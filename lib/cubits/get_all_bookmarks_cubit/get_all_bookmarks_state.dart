part of 'get_all_bookmarks_cubit.dart';

@immutable
sealed class GetAllBookmarksState {}

final class GetAllBookmarksInitial extends GetAllBookmarksState {}
class GetAllBookmarksLoading extends GetAllBookmarksState {}

class GetAllBookmarksFailure extends GetAllBookmarksState {
  final String error;
  GetAllBookmarksFailure(this.error);
}

class GetAllBookmarksSuccess extends GetAllBookmarksState {
  final List<BookmarkItem> bookmarks;
  GetAllBookmarksSuccess({required this.bookmarks});
}
