class GetAllChatsResponse {
  final bool? status;
  final List<ChatItem>? chats;

  GetAllChatsResponse({this.status, this.chats});

  factory GetAllChatsResponse.fromJson(Map<String, dynamic> json) {
    return GetAllChatsResponse(
      status: json["status"],
      chats: json["chats"] == null
          ? []
          : List<ChatItem>.from(json["chats"].map((x) => ChatItem.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    "status": status,
    "chats": chats?.map((x) => x.toJson()).toList(),
  };
}

class ChatItem {
  final String? id;
  final List<ChatUser>? users;
  final LatestMsg? latestMessage;
  final String? createdAt;
  final String? updatedAt;

  ChatItem({
    this.id,
    this.users,
    this.latestMessage,
    this.createdAt,
    this.updatedAt,
  });

  factory ChatItem.fromJson(Map<String, dynamic> json) {
    return ChatItem(
      id: json["_id"],
      users: json["users"] == null
          ? []
          : List<ChatUser>.from(json["users"].map((x) => ChatUser.fromJson(x))),
      latestMessage: json["latestMessage"] == null
          ? null
          : LatestMsg.fromJson(json["latestMessage"]),
      createdAt: json["createdAt"],
      updatedAt: json["updatedAt"],
    );
  }

  Map<String, dynamic> toJson() => {
    "_id": id,
    "users": users?.map((x) => x.toJson()).toList(),
    "latestMessage": latestMessage?.toJson(),
    "createdAt": createdAt,
    "updatedAt": updatedAt,
  };
}

class ChatUser {
  final String? id;
  final String? username;
  final String? imageUrl;
  final String? location;

  ChatUser({this.id, this.username, this.imageUrl, this.location});

  factory ChatUser.fromJson(Map<String, dynamic> json) {
    return ChatUser(
      id: json["_id"],
      username: json["username"],
      imageUrl: json["imageUrl"],
      location: json["location"],
    );
  }

  Map<String, dynamic> toJson() => {
    "_id": id,
    "username": username,
    "imageUrl": imageUrl,
    "location": location,
  };
}

class LatestMsg {
  final String? id;
  final String? content;

  LatestMsg({this.id, this.content});

  factory LatestMsg.fromJson(Map<String, dynamic> json) {
    return LatestMsg(
      id: json["_id"],
      content: json["content"],
    );
  }

  Map<String, dynamic> toJson() => {
    "_id": id,
    "content": content,
  };
}