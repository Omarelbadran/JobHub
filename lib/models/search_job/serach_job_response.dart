import '../job_model/job_model.dart';

class SearchJobsResponse {
  final bool status;
  final List<JobModel> searchResults;

  SearchJobsResponse({
    required this.status,
    required this.searchResults,
  });

  factory SearchJobsResponse.fromJson(Map<String, dynamic> json) {
    return SearchJobsResponse(
      status: json['status'] ?? false,
      searchResults: json['searchResults'] != null
          ? List<JobModel>.from(
        json['searchResults'].map((e) => JobModel.fromJson(e)),
      )
          : [],
    );
  }
}