import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:job_hub_app/main_views/chat_view/widgets/chat_app_bar.dart';
import 'package:job_hub_app/main_views/chat_view/widgets/message_input.dart';
import 'package:job_hub_app/main_views/chat_view/widgets/messages_list.dart';
import '../../cubits/messages_cubit/messages_cubit.dart';

class ChatView extends StatelessWidget {
  final String userName;
  final String userImage;
  final String chatId;
  final String receiverId;

  const ChatView({
    super.key,
    required this.userName,
    required this.userImage,
    required this.chatId,
    required this.receiverId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: Column(
            children: [
              ChatAppBar(
                onPressed: () => Navigator.pop(context),
                title: userName,
                userImage: userImage,
              ),
              Expanded(
                child: RefreshIndicator(
                  color: Colors.blue,
                  onRefresh: () async {
                    final prefs = await SharedPreferences.getInstance();
                    final token = prefs.getString('token') ?? "";

                    if (context.mounted) {
                      context.read<MessagesCubit>().fetchMessages(
                        token,
                        chatId,
                      );
                    }
                  },
                  child:  MessagesList(chatId: chatId),
                ),
              ),
              MessageInput(chatId: chatId, receiverId: receiverId),
            ],
          ),
        ),
      ),
    );
  }
}
