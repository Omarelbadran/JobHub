class DeleteBookmarkResponse {
  bool? status;
  String? message;

  DeleteBookmarkResponse({this.status, this.message});

  factory DeleteBookmarkResponse.fromJson(Map<String, dynamic> json) {
    return DeleteBookmarkResponse(
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