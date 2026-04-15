import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../api/api_errors.dart';
import '../../models/job_model/job_model.dart';
import '../../models/search_job/serach_job_response.dart';
import '../../repos/main_repo.dart';

part 'search_jobs_state.dart';
class SearchJobsCubit extends Cubit<SearchJobsState> {
  SearchJobsCubit() : super(SearchJobsInitial());
  bool isSearching = false;

  void toggleSearch() {
    isSearching = !isSearching;
    emit(SearchJobsInitial());
  }

  void closeSearch() {
    isSearching = false;
    emit(SearchJobsInitial());
  }
  Future<void> searchJobs(String query) async {

    final cleanQuery = query.trim();

    if (cleanQuery.isEmpty) {
      emit(SearchJobsInitial());
      return;
    }

    emit(SearchJobsLoading());

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token == null) {
        emit(SearchJobsFailure("Token not found"));
        return;
      }

      final response = await MainRepo.searchJobs(token, cleanQuery);

      final jobs = response.searchResults;

      emit(SearchJobsSuccess(jobs));

    } on Exception catch (e) {
      String errorMessage = APIError.getErrorMessage(e);
      emit(SearchJobsFailure(errorMessage));
    }
  }
}
