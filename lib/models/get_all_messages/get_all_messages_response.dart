class GetAllMessagesResponse {
  bool? status;
  List<MessageItem>? messages;

  GetAllMessagesResponse({this.status, this.messages});

  factory GetAllMessagesResponse.fromJson(Map<String, dynamic> json) {
    return GetAllMessagesResponse(
      status: json["status"],
      messages: json["messages"] == null
          ? null
          : List<MessageItem>.from(json["messages"].map((x) => MessageItem.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    "status": status,
    "messages": messages == null ? null : List<dynamic>.from(messages!.map((x) => x.toJson())),
  };
}

class MessageItem {
  String? id;
  String? content;
  MessageSender? sender;
  String? createdAt;

  MessageItem({this.id, this.content, this.sender, this.createdAt});

  MessageItem.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    content = json["content"];
    sender = json["sender"] == null ? null : MessageSender.fromJson(json["sender"]);
    createdAt = json["createdAt"];
  }

  Map<String, dynamic> toJson() => {
    "_id": id,
    "content": content,
    "sender": sender?.toJson(),
    "createdAt": createdAt,
  };
}

class MessageSender {
  String? id;
  String? username;
  String? imageUrl;

  MessageSender({this.id, this.username, this.imageUrl});

  MessageSender.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    username = json["username"];
    imageUrl = json["imageUrl"];
  }

  Map<String, dynamic> toJson() => {
    "_id": id,
    "username": username,
    "imageUrl": imageUrl,
  };
}