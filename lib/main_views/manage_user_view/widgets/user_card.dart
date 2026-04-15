import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../../../cubits/chat_cubit/chat_cubit.dart';
import '../../../cubits/messages_cubit/messages_cubit.dart';
import '../../../models/login/login_response.dart';
import '../../chat_view/chat_view.dart';

class UserCard extends StatelessWidget {
  final UserData user;

  const UserCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Slidable(
      key: ValueKey(user.id),
      startActionPane: ActionPane(
        motion: const BehindMotion(),
        extentRatio: 0.5,
        children: [
          SlidableAction(
            onPressed: (context) {
            },
            backgroundColor: Colors.deepOrange,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12.r),
              bottomLeft: Radius.circular(12.r),
            ),
          ),

          SlidableAction(
            onPressed: (context) {
              final chatCubit = context.read<ChatCubit>();
              final messagesCubit = context.read<MessagesCubit>();

              messagesCubit.resetMessages();

              String foundChatId = "";
              if (chatCubit.state is GetAllChatsSuccess) {
                final allChats = (chatCubit.state as GetAllChatsSuccess).chats;
                for (var chat in allChats) {
                  if (chat.users?.any((u) => u.id == user.id) ?? false) {
                    foundChatId = chat.id ?? "";
                    break;
                  }
                }
              }

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatView(
                    userName: user.username ?? "",
                    userImage: user.imageUrl ?? "",
                    chatId: foundChatId,
                    receiverId: user.id ?? "",
                  ),
                ),
              );
            },
            backgroundColor: const Color(0xFF00BFA5), // لون تيل/أخضر مائي
            foregroundColor: Colors.white,
            icon: Icons.chat_bubble,
            label: 'Chat',
          ),
        ],
      ),

      // الكارد الأصلي بتاعك
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 10.h),
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: .2),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            Container(
              width: 50.w,
              height: 50.h,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              // ممكن تحط صورة المستخدم هنا لو موجودة
            ),
            SizedBox(width: screenWidth * .015),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.username ?? '',
                    style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    child: Text(
                      user.email ?? '',
                      maxLines: 1,
                      style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        color: Colors.black.withValues(alpha: .4),
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * .005),
                  Text(
                    user.phone ?? '',
                    style: TextStyle(
                      color: Colors.black.withValues(alpha: .4),
                      fontSize: 18.sp,
                    ),
                  ),
                ],
              ),
            ),
            CircleAvatar(
              radius: 16.r,
              backgroundColor: Colors.deepOrange,
              child:  Icon(
                Icons.arrow_forward_ios,
                size: 18.sp, // صغرت الحجم شوية عشان يتناسق
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}