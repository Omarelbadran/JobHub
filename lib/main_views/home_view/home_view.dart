import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_hub_app/main_views/home_view/widgets/custom_drawer_menu.dart';
import 'package:job_hub_app/main_views/home_view/widgets/home_body_content.dart';
import 'package:job_hub_app/main_views/home_view/widgets/settings_decision.dart';
import 'package:job_hub_app/main_views/settings_view/settings_view.dart';
import '../../cubits/drawer_menu_cubit/drawer_menu_cubit.dart';
import '../book_mark_view/book_mark_view.dart';
import '../profile_view/profile_view.dart';
import '../show_chat_view/show_chat_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => DrawerMenuCubit(),
      child: Scaffold(
        backgroundColor: const Color(0xFF3B67E1),
        body: BlocBuilder<DrawerMenuCubit, DrawerMenuState>(
          builder: (context, state) {
            bool isMenuOpen = state is DrawerMenuOpen;
            final List<Widget> pages = [
              const HomeBodyContent(),
              const ShowChatView(),
              const BookMarkView(),
              const SettingsDecision(),
              const ProfileView(),
            ];
            int currentIndex = state.selectedIndex;
            return Stack(
              children: [
                const CustomDrawerMenu(),

               GestureDetector(
                 onDoubleTap: !isMenuOpen ? () {
                   context.read<DrawerMenuCubit>().toggleDrawer();
                 } : null,

                 onTap: isMenuOpen ? () {
                   context.read<DrawerMenuCubit>().toggleDrawer();
                 } : null,
                 child: AnimatedContainer(
                   duration: const Duration(milliseconds: 300),
                   curve: Curves.easeInOut,
                   transform: Matrix4.translationValues(
                     isMenuOpen ? 200.w : 0,
                     isMenuOpen ? 50.h : 0,
                     0,
                   )..scale(isMenuOpen ? 0.85 : 1.0),
                   child: ClipRRect(
                     borderRadius: BorderRadius.circular(isMenuOpen ? 35.r : 0),
                     child: Container(
                       color: Colors.white,
                       child: AnimatedSwitcher(
                           duration: const Duration(milliseconds: 300),
                           child: pages[currentIndex]),
                     ),
                   ),
                 ),
               ),
            ]
            );
          },
        ),
      ),
    );
  }
}

