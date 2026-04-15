import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../cubits/messages_cubit/messages_cubit.dart';
import '../../../models/get_all_chats/get_all_chats_response.dart';
import '../../chat_view/chat_view.dart';

class ChatCard extends StatelessWidget {
  final ChatItem chatItem;
  final String myId;

  const ChatCard({super.key, required this.chatItem, required this.myId});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    final otherUser = chatItem.users?.firstWhere(
      (user) => user.id != myId,
      orElse: () => chatItem.users![0],
    );
    return InkWell(
      onTap: () async {
        final prefs = await SharedPreferences.getInstance();
        String? token = prefs.getString('token');

        if (token != null && context.mounted) {
          context.read<MessagesCubit>().fetchMessages(token, chatItem.id!);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatView(
                userName: otherUser?.username ?? "User",
                userImage: otherUser?.imageUrl ?? "",
                chatId: chatItem.id ?? "",
                receiverId: otherUser?.id ?? "",
              ),
            ),
          );
        }
      },
      child: Container(
        width: 200.w,
        height: 80.h,
        margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 10.h),
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: .2),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            Container(
              width: 50.w,
              height: 50.h,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30.r),
                child: Image.network(
                  otherUser?.imageUrl ?? "",
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.person),
                ),
              ),
            ),
            SizedBox(width: screenWidth * .02),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 90.w,
                      child: Text(
                        otherUser?.username ?? 'User',
                        style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          color: Colors.black,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      chatItem.updatedAt?.substring(0, 10) ?? '',
                      style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        color: Colors.black,
                        fontSize: 15.sp,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * .005),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 200.w,
                      child: Text(
                        chatItem.latestMessage?.content ?? "No messages",
                        style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          color: Colors.black,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      height: 20.h,
                      width: 20.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black.withValues(alpha: .1),
                        border: Border.all(color: Colors.black, width: 1.5.r),
                      ),
                      child: Icon(Icons.arrow_forward, size: 20),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
