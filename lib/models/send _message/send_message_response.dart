class SendMessageResponse {
  bool? status;
  SentMessageData? sentMessage;

  SendMessageResponse({this.status, this.sentMessage});

  factory SendMessageResponse.fromJson(Map<String, dynamic> json) {
    return SendMessageResponse(
      status: json["status"],
      sentMessage: json["sentMessage"] == null ? null : SentMessageData.fromJson(json["sentMessage"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "status": status,
    "sentMessage": sentMessage?.toJson(),
  };
}

class SentMessageData {
  String? id;
  String? content;
  String? chatId;
  String? createdAt;

  SentMessageData({this.id, this.content, this.chatId, this.createdAt});

  SentMessageData.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    content = json["content"];
    chatId = json["chat"] is Map ? json["chat"]["_id"] : json["chat"];
    createdAt = json["createdAt"];
  }

  Map<String, dynamic> toJson() => {
    "_id": id,
    "content": content,
    "chat": chatId,
    "createdAt": createdAt,
  };
}