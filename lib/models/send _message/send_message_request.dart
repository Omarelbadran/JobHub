class SendMessageRequest {
  String? content;
  String? chatId;
  String? receiverId;

  SendMessageRequest({this.content, this.chatId, this.receiverId});

  Map<String, dynamic> toJson() {
    return {
      "content": content,
      "chatId": chatId,
      "receiverId": receiverId,
    };
  }
}