class AccessChatResponse {
  bool? status;
  FullChat? fullChat;

  AccessChatResponse({this.status, this.fullChat});

  factory AccessChatResponse.fromJson(Map<String, dynamic> json) {
    return AccessChatResponse(
      status: json["status"],
      fullChat: json["fullChat"] == null ? null : FullChat.fromJson(json["fullChat"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "status": status,
    "fullChat": fullChat?.toJson(),
  };
}

class FullChat {
  String? id;
  List<ChatParticipant>? users;
  String? createdAt;
  String? updatedAt;

  FullChat({this.id, this.users, this.createdAt, this.updatedAt});

  FullChat.fromJson(Map<String, dynamic> json) {
    id = json["_id"];
    users = json["users"] == null
        ? null
        : List<ChatParticipant>.from(json["users"].map((x) => ChatParticipant.fromJson(x)));
    createdAt = json["createdAt"];
    updatedAt = json["updatedAt"];
  }

  Map<String, dynamic> toJson() => {
    "_id": id,
    "users": users == null ? null : List<dynamic>.from(users!.map((x) => x.toJson())),
    "createdAt": createdAt,
    "updatedAt": updatedAt,
  };
}

class ChatParticipant {
  String? id;
  String? username;
  String? imageUrl;

  ChatParticipant({this.id, this.username, this.imageUrl});

  ChatParticipant.fromJson(Map<String, dynamic> json) {
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