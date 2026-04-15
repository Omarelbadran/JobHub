part of 'chat_cubit.dart';

@immutable
sealed class ChatState {}

final class ChatInitial extends ChatState {}
class ChatLoading extends ChatState {}

class GetAllChatsSuccess extends ChatState {
  final List<ChatItem> chats;
  GetAllChatsSuccess(this.chats);
}

class AccessChatSuccess extends ChatState {
  final String chatId;
  AccessChatSuccess(this.chatId);
}

class ChatFailure extends ChatState {
  final String error;
  ChatFailure(this.error);
}