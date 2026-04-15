class DeleteJobRequest {
  String? jobId;

  DeleteJobRequest({this.jobId});

  factory DeleteJobRequest.fromJson(Map<String, dynamic> json) {
    return DeleteJobRequest(
      jobId: json['jobId'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['jobId'] = jobId;
    return data;
  }
}