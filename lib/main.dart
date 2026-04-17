import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_hub_app/auth_views/first_splash_screen_view/first_splash_screen_view.dart';
import 'package:job_hub_app/auth_views/login_view/login_view.dart';
import 'package:job_hub_app/cubits/messages_cubit/messages_cubit.dart';
import 'cubits/chat_cubit/chat_cubit.dart';
import 'cubits/get_all_bookmarks_cubit/get_all_bookmarks_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => GetAllBookmarksCubit()..getAllBookmarks(),
          ),
          BlocProvider(create: (context) => ChatCubit()),
          BlocProvider(create: (context) => MessagesCubit()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: const FirstSplashScreenView(),
        ),
      ),
    );
  }
}
