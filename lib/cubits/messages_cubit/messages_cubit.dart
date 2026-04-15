import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import '../../api/api_errors.dart';
import '../../models/get_all_messages/get_all_messages_response.dart';
import '../../models/send _message/send_message_request.dart';
import '../../models/send _message/send_message_response.dart';
import '../../repos/main_repo.dart';

part 'messages_state.dart';

class MessagesCubit extends Cubit<MessagesState> {
  MessagesCubit() : super(MessagesInitial());
  final TextEditingController messageController = TextEditingController();

  @override
  Future<void> close() {
    messageController.dispose();
    return super.close();
  }
  void resetMessages() {
    emit(MessagesInitial());
  }
  // 1. جلب الرسائل (السيرفر بيبعتها أحدث حاجة في Index 0)
  void fetchMessages(String token, String chatId) async {
    emit(MessagesLoading());
    try {
      final response = await MainRepo.getMessages(token, chatId);
      if (response.status == true) {
        // ✅ شيلنا الـ reversed لأن الـ JSON اللي بعته بيبدأ بالأحدث فعلاً
        // وكده index 0 هو أحدث رسالة هتظهر تحت خالص في الـ ListView المعكوسة
        final messages = response.messages ?? [];
        emit(GetMessagesSuccess(messages));
      } else {
        emit(MessagesFailure("There is no messages"));
      }
    } on Exception catch (e) {
      String errorMessage = APIError.getErrorMessage(e);
      emit(MessagesFailure(errorMessage));
    }
  }

  // 2. إرسال الرسالة وإضافتها في أول اللستة
  void sendMessage(String token, String chatId, String myId, String receiverId) async {
    final text = messageController.text.trim();
    if (text.isEmpty) return;

    List<MessageItem> currentMessages = [];
    if (state is GetMessagesSuccess) {
      currentMessages = List<MessageItem>.from((state as GetMessagesSuccess).messages ?? []);
    }

    try {
      messageController.clear();
      final request = SendMessageRequest(chatId: chatId, content: text, receiverId: receiverId);
      final response = await MainRepo.sendMessage(token, request);

      if (response.status == true && response.sentMessage != null) {
        final newMessage = MessageItem(
          id: response.sentMessage!.id,
          content: response.sentMessage!.content,
          createdAt: response.sentMessage!.createdAt,
          sender: MessageSender(id: myId),
        );

        currentMessages.insert(0, newMessage);
        emit(GetMessagesSuccess(List.from(currentMessages)));
      }
    } on Exception catch (e) {
      if (e is DioException) {
        print("Server Error Detail: ${e.response?.data}");
      }
      String errorMessage = APIError.getErrorMessage(e);
      emit(MessagesFailure(errorMessage));
    }
  }
}