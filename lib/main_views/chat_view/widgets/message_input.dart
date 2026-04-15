import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../cubits/chat_cubit/chat_cubit.dart';
import '../../../cubits/messages_cubit/messages_cubit.dart';
class MessageInput extends StatelessWidget {
  final String chatId;
  final String receiverId;
  const MessageInput({super.key, required this.chatId, required this.receiverId});

  @override
  Widget build(BuildContext context) {
    final messagesCubit = context.read<MessagesCubit>();
    final chatCubit = context.read<ChatCubit>();
    return Padding(
      padding:  EdgeInsets.all(6.r),
      child: Container(
        padding:  EdgeInsets.symmetric(horizontal: 16.w),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
             Expanded(
              child: TextField(
                controller: messagesCubit.messageController,
                decoration: InputDecoration(
                  hintText: "Type your Message...",
                  border: InputBorder.none,
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.send, color: Colors.blue),
              onPressed: () async {
                final content = messagesCubit.messageController.text.trim();
                if (content.isEmpty) return;

                final prefs = await SharedPreferences.getInstance();
                final token = prefs.getString('token');
                final myId = chatCubit.currentUserId;

                if (token != null && myId != null && context.mounted) {
                  // 1. لو الـ chatId مبعوت بـ "" (يعني شات جديد من الـ UserCard)
                  if (chatId.isEmpty) {
                    // اطلب إنشاء المحادثة أولاً
                    chatCubit.accessChat(token, receiverId);

                    // اسمع للـ Cubit لمرة واحدة فقط عشان تبعت الرسالة أول ما الـ ID يوصل
                    late StreamSubscription subscription;
                    subscription = chatCubit.stream.listen((state) {
                      if (state is AccessChatSuccess) {
                        // مبروك الـ ID وصل -> ابعت الرسالة بالـ ID الجديد
                        messagesCubit.sendMessage(
                          token,
                          state.chatId, // الـ ID اللي لسه راجع من السيرفر
                          myId,
                          receiverId,
                        );
                        subscription.cancel(); // وقف السمع فوراً
                      } else if (state is ChatFailure) {
                        subscription.cancel(); // وقف لو حصل فشل
                      }
                    });
                  } else {
                    // 2. حالة الشات القديم (معانا chatId حقيقي)
                    messagesCubit.sendMessage(token, chatId, myId, receiverId);
                  }

                  // مسح النص بعد الإرسال
                  messagesCubit.messageController.clear();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}