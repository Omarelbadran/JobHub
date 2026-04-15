part of 'messages_cubit.dart';

@immutable
sealed class MessagesState {}

final class MessagesInitial extends MessagesState {}
class MessagesLoading extends MessagesState {}

class GetMessagesSuccess extends MessagesState {
  final List<MessageItem> messages;
  GetMessagesSuccess(this.messages);
}

class SendMessageSuccess extends MessagesState {
  final SentMessageData sentMessage;
  SendMessageSuccess(this.sentMessage);
}

class MessagesFailure extends MessagesState {
  final String error;
  MessagesFailure(this.error);
}
