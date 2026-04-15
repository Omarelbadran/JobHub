import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../api/api_errors.dart';
import '../../models/add_bookmark/add_book_mark_request.dart';
import '../../models/add_bookmark/add_book_mark_response.dart';
import '../../repos/main_repo.dart';

part 'add_bookmark_state.dart';

class AddBookmarkCubit extends Cubit<AddBookmarkState> {
  AddBookmarkCubit() : super(AddBookmarkInitial());

  Future<void> addBookmark(String jobId) async {
    emit(AddBookmarkLoading());

    try {
      final prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("token") ?? "";

      final response = await MainRepo.addBookmark(
        token,
        AddBookmarkRequest(jobId: jobId),
      );

      if (response.status == true) {
        emit(AddBookmarkSuccess(response));
      } else {
        emit(AddBookmarkFailure(response.message ?? "Something went wrong"));
      }
    } on Exception catch (e) {
      String errorMessage = APIError.getErrorMessage(e);
      emit(AddBookmarkFailure(errorMessage));
    }
  }
}
