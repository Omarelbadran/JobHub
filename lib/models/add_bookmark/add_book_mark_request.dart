class AddBookmarkRequest {
  String? jobId;

  AddBookmarkRequest({this.jobId});

 factory AddBookmarkRequest.fromJson(Map<String, dynamic> json) {
    return AddBookmarkRequest(
      jobId: json['jobId'],
    );
 }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['jobId'] = jobId;
    return data;
  }
}