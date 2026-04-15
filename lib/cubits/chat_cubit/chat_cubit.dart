import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../api/api_errors.dart';
import '../../models/access_chat/access_chat_request.dart';
import '../../models/get_all_chats/get_all_chats_response.dart';
import '../../repos/main_repo.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());
  String? currentUserId;
 Future <void> fetchAllChats(String token , String myId) async {
    currentUserId = myId;
    emit(ChatLoading());
    try {
      final response = await MainRepo.getAllChats(token);
      if (response.status == true) {
        emit(GetAllChatsSuccess(response.chats ?? []));
      } else {
        emit(ChatFailure("Failed to fetch chats"));
      }
    } on Exception catch (e) {
      String errorMessage = APIError.getErrorMessage(e);
      emit(ChatFailure(errorMessage));
    }
  }

  void accessChat(String token, String userId) async {
    emit(ChatLoading());
    try {
      final request = AccessChatRequest(userId: userId);
      final response = await MainRepo.accessChat(token, request);

      if (response.status == true && response.fullChat != null) {
        emit(AccessChatSuccess(response.fullChat!.id!));
      } else {
        emit(ChatFailure("Failed to access chat"));
      }
    } on Exception catch (e) {
      String errorMessage = APIError.getErrorMessage(e);
      emit(ChatFailure(errorMessage));
    }
  }
}
