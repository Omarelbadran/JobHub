import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_hub_app/main_views/admin_panel_view/admin_panel_view.dart';
import 'package:job_hub_app/main_views/manage_user_view/widgets/user_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../cubits/chat_cubit/chat_cubit.dart';
import '../../widgets/settings_app_bar.dart';
class ManageUserView extends StatelessWidget {
  const ManageUserView({super.key});
  Future<void> _initializeChatData(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? "";
    final myId = prefs.getString('userId') ?? "";

    if (context.mounted) {
      await context.read<ChatCubit>().fetchAllChats(token, myId);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: 12.w),
            child: Column(
              children: [
                SettingsAppBar(
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    title: 'Manage Users'),
                Expanded(
                  child: FutureBuilder(
                    future: _initializeChatData(context),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      return const UserList();
                    },
                  ),
                ),
              ],
            ),
          )
      ),
    );
  }
}
