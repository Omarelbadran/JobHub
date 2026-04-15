class DeleteBookmarkRequest {
  String? bookmarkId;

  DeleteBookmarkRequest({this.bookmarkId});

  factory DeleteBookmarkRequest.fromJson(Map<String, dynamic> json) {
    return DeleteBookmarkRequest(
      bookmarkId: json['bookmarkId'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['bookmarkId'] = bookmarkId;
    return data;
  }
}