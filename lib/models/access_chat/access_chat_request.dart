class AccessChatRequest {
  String? userId;

  AccessChatRequest({this.userId});

  Map<String, dynamic> toJson() {
    return {
      "userId": userId,
    };
  }
}