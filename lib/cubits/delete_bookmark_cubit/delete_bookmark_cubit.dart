import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../api/api_errors.dart';
import '../../models/delete_boomark/delete_bookmark_request.dart';
import '../../models/delete_boomark/delete_bookmark_response.dart';
import '../../repos/main_repo.dart';

part 'delete_bookmark_state.dart';

class DeleteBookmarkCubit extends Cubit<DeleteBookmarkState> {
  DeleteBookmarkCubit() : super(DeleteBookmarkInitial());

  Future<void> deleteBookmark(String bookmarkId) async {
    emit(DeleteBookmarkLoading());
    try {
      final prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("token") ?? "";

      final response = await MainRepo.deleteBookmark(
        token,
        DeleteBookmarkRequest(bookmarkId: bookmarkId),
      );

      if (response.status == true) {
        emit(DeleteBookmarkSuccess(response));
      } else {
        emit(DeleteBookmarkFailure(response.message ?? "Something went wrong"));
      }
    } on Exception catch (e) {
      String errorMessage = APIError.getErrorMessage(e);
      emit(DeleteBookmarkFailure(errorMessage));
    }
  }
}
