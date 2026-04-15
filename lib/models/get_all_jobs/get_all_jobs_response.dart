import '../job_model/job_model.dart';

class GetAllJobsResponse {
  final bool status;
  final List<JobModel> jobs;

  GetAllJobsResponse({
    required this.status,
    required this.jobs,
  });

  factory GetAllJobsResponse.fromJson(Map<String, dynamic> json) {
    return GetAllJobsResponse(
      status: json['status'],
      jobs: json['jobs'] != null
          ? List<JobModel>.from(
        json['jobs'].map((e) => JobModel.fromJson(e)),
      )
          : [],
    );
  }
}