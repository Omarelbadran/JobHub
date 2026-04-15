import '../../models/job_model/job_model.dart';

class UpdateJobResponse {
  bool? status;
  JobModel? job;

  UpdateJobResponse({this.status, this.job});

  factory UpdateJobResponse.fromJson(Map<String, dynamic> json) {
    return UpdateJobResponse(
      status: json['status'],
      job: json['job'] != null ? JobModel.fromJson(json['job']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['status'] = status;
    if (job != null) {
      data['job'] = job!.toJson();
    }
    return data;
  }
}