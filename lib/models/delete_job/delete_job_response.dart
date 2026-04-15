class DeleteJobResponse {
  bool? status;
  String? message;

  DeleteJobResponse({this.status, this.message});

  factory DeleteJobResponse.fromJson(Map<String, dynamic> json) {
    return DeleteJobResponse(
      status: json['status'],
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['status'] = status;
    data['message'] = message;
    return data;
  }
}