import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../api/api_errors.dart';
import '../../models/get_all_bookmarks/get_all_bookmarks_response.dart';
import '../../repos/main_repo.dart';

part 'get_all_bookmarks_state.dart';

class GetAllBookmarksCubit extends Cubit<GetAllBookmarksState> {
  GetAllBookmarksCubit() : super(GetAllBookmarksInitial());
  Map<String, String> jobsToBookmarksMap = {};

  Future<void> getAllBookmarks() async {
    emit(GetAllBookmarksLoading());
    try {
      final prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("token") ?? "";

      final response = await MainRepo.getAllBookmarks(token);

      if (response.status == true) {
        // تحديث الخريطة (Caching)
        jobsToBookmarksMap.clear();
        for (var item in response.bookmarks) {
          // بنربط الـ jobId بالـ bookmarkId
          jobsToBookmarksMap[item.job!.id.toString()] = item.bookmarkId;
        }

        emit(GetAllBookmarksSuccess(bookmarks: response.bookmarks));
      } else {
        emit(GetAllBookmarksFailure("Something went wrong"));
      }
    } on Exception catch (e) {
      print("🚨 Error in Bookmarks: ${e.toString()}"); //
      String errorMessage = APIError.getErrorMessage(e);
      emit(GetAllBookmarksFailure(errorMessage));
    }
  }
}
