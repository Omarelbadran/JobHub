import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_hub_app/main_views/show_chat_view/widgets/chat_list.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../../cubits/chat_cubit/chat_cubit.dart';
import '../home_view/widgets/home_app_bar.dart';

class ShowChatView extends StatelessWidget {
  const ShowChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: Column(
            children: [
              HomeAppBar(title: 'Chats'),
              Expanded(
                child: RefreshIndicator(
                  color: Colors.blue,
                  onRefresh: () async {
                    final prefs = await SharedPreferences.getInstance();
                    final token = prefs.getString('token') ?? "";

                    final userDataString = prefs.getString('userData');
                    String myId = "";
                    if (userDataString != null) {
                      final userData = jsonDecode(userDataString);
                      myId = userData['_id'] ?? "";
                    }

                    if (context.mounted) {
                      await context.read<ChatCubit>().fetchAllChats(token, myId);
                    }
                  },
                  child: const ChatList(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}