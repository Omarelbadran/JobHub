import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_hub_app/cubits/chat_cubit/chat_cubit.dart';
import 'package:job_hub_app/main_views/show_chat_view/widgets/chat_card.dart';
import 'package:job_hub_app/main_views/show_job_view/widgets/show_job_card.dart';

class ChatList extends StatelessWidget {
  const ChatList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatCubit, ChatState>(
      builder: (context, state) {
        if (state is ChatLoading) {
          return const Center(child: CircularProgressIndicator(color: Colors.orange));
        } else if (state is GetAllChatsSuccess) {
          if (state.chats.isEmpty) {
            return const Center(child: Text("No chats yet"));
          }
          final myId = context.read<ChatCubit>().currentUserId ?? "";
          return ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: state.chats.length,
            itemBuilder: (context, index) {
              return ChatCard(
                  chatItem: state.chats[index],
                myId: myId,
              );
            },
          );
        } else if (state is ChatFailure) {
          return Center(child: Text(state.error));
        }
        return const Center(child: Text("Start messaging now"));
      },
    );
      }
  }

