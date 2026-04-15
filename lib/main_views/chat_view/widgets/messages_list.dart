import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_hub_app/cubits/messages_cubit/messages_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../cubits/chat_cubit/chat_cubit.dart';
import 'chat_bubble.dart';

class MessagesList extends StatelessWidget {
  final String? chatId;

  const MessagesList({super.key, this.chatId});

  @override
  Widget build(BuildContext context) {
    final messagesCubit = context.read<MessagesCubit>();
    final String activeId = chatId ?? "";

    return FutureBuilder<SharedPreferences>(
        future: SharedPreferences.getInstance(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator(color: Colors.orange));
          }

          final prefs = snapshot.data!;
          final String myId = prefs.getString('userId') ?? "";
          final String token = prefs.getString('token') ?? "";

          if (activeId.isNotEmpty && messagesCubit.state is MessagesInitial) {
            messagesCubit.fetchMessages(token, activeId);
          }


          return BlocBuilder<MessagesCubit, MessagesState>(
            builder: (context, state) {
              if (state is MessagesLoading) {
                return const Center(
                  child: CircularProgressIndicator(color: Colors.orange),
                );
              } else if (state is GetMessagesSuccess) {
                final messages = state.messages;
                if (messages.isEmpty) {
                  return const Center(child: Text("Start the conversation!"));
                }
                return ListView.builder(
                  reverse: true,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final msg = messages[index];
                    final String senderId = msg.sender?.id ?? "";
                    print("DEBUG: SenderFromAPI: '$senderId' | MyIdFromPrefs: '$myId'");
                    bool isMe = senderId == myId;
                    return ChatBubble(

                      message: msg.content ?? "",
                      userImageUrl: msg.sender?.imageUrl,                      isMe: isMe,
                      time: (msg.createdAt != null && msg.createdAt!.length >= 16)
                          ? msg.createdAt!.substring(11, 16)
                          : "",
                    );
                  },
                );
              } else if (state is MessagesFailure) {
                return Center(child: Text(state.error));
              }
              return const SizedBox();
            },
          );
        }
    );
  }
}
