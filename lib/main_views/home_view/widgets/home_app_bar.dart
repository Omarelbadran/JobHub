import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_hub_app/main_views/profile_view/profile_view.dart';
import 'package:job_hub_app/main_views/update_user_view/update_user_view.dart';

import '../../../cubits/drawer_menu_cubit/drawer_menu_cubit.dart';
class HomeAppBar extends StatelessWidget {
  final String? title;
  const HomeAppBar({super.key, this.title });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () {
            context.read<DrawerMenuCubit>().toggleDrawer();
          },

          customBorder: const CircleBorder(),
          child: Container(
            height: 35.h,
            width: 35.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              border: Border.all(
                color: Colors.black,
                width: 1.r,
              ),
            ),
            child: Center(
              child: Icon(
                Icons.list_sharp,
                size: 18.sp,
                color: Colors.black,
              ),
            ),
          ),
        ),
        Text(
          '$title' ,
          style: TextStyle(
          fontSize: 16.sp,
          fontWeight:FontWeight.bold,
        ),),
        GestureDetector(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileView()));
          },
          child: Container(
            height: 35.h,
            width: 35.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: Image.asset('assets/images/user.png'),
          ),
        ),
      ],
    );
  }
}
