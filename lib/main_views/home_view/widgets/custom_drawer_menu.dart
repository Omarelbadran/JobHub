import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../auth_views/login_view/login_view.dart';
import '../../../cubits/chat_cubit/chat_cubit.dart';
import '../../../cubits/drawer_menu_cubit/drawer_menu_cubit.dart';

import '../../../repos/auth_repo.dart';
import 'drawer_item.dart';

class CustomDrawerMenu extends StatelessWidget {
  const CustomDrawerMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final int currentIndex = context
        .watch<DrawerMenuCubit>()
        .state
        .selectedIndex;
    return Padding(
      padding: EdgeInsets.only(left: 20.w, top: 120.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DrawerItem(
            icon: Icons.home_outlined,
            title: "Home",
            isSelected: currentIndex == 0,
            onTap: () {
              context.read<DrawerMenuCubit>().changePage(0);
            },
          ),
          DrawerItem(
            icon: Icons.chat_bubble_outline,
            title: "Chat",
            isSelected: currentIndex == 1,
            onTap: () async {
              context.read<DrawerMenuCubit>().changePage(1);
              final prefs = await SharedPreferences.getInstance();

              String? userToken = prefs.getString('token');
              String? userDataJson = prefs.getString('userData');

              if (userToken != null && userDataJson != null) {
                var userData = jsonDecode(userDataJson);
                String myId = userData['_id'];

                context.read<ChatCubit>().fetchAllChats(userToken, myId);
              }
            },
          ),
          DrawerItem(
            icon: Icons.bookmark_border,
            title: "Bookmarks",
            isSelected: currentIndex == 2,
            onTap: () {
              context.read<DrawerMenuCubit>().changePage(2);
            },
          ),
          DrawerItem(
            icon: Icons.settings_outlined,
            title: "Settings",
            isSelected: currentIndex == 3,
            onTap: () {
              context.read<DrawerMenuCubit>().changePage(3);
            },
          ),
          DrawerItem(
            icon: Icons.person_outline,
            title: "Profile",
            isSelected: currentIndex == 4,
            onTap: () {
              context.read<DrawerMenuCubit>().changePage(4);
            },
          ),

          const Spacer(),
          DrawerItem(
            icon: Icons.logout,
            title: "Logout",
            onTap: () {
              // إظهار Dialog للتأكيد (أفضل عشان اليوزر ميعملش Logout بالغلط)
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text("Logout"),
                  content: const Text("Are you sure you want to logout?"),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Cancel"),
                    ),
                    TextButton(
                      onPressed: () async {
                        // 1. مسح البيانات من الـ Cache
                        await AuthRepo.logout();

                        // 2. الرجوع لصفحة الـ Login ومسح الـ Stack
                        if (context.mounted) {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginView(),
                            ),
                            (route) => false,
                          );
                        }
                      },
                      child: const Text(
                        "Logout",
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          SizedBox(height: 50.h),
        ],
      ),
    );
  }
}
