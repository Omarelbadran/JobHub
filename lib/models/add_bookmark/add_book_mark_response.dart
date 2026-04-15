class AddBookmarkResponse {
  bool? status;
  String? message;

  AddBookmarkResponse({this.status, this.message});

  factory AddBookmarkResponse.fromJson(Map<String, dynamic> json) {
    return AddBookmarkResponse(
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