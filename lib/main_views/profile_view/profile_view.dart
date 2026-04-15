import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_hub_app/cubits/get_user_cubit/get_user_cubit.dart';
import 'package:job_hub_app/main_views/home_view/widgets/home_app_bar.dart';
import 'package:job_hub_app/main_views/profile_view/widgets/item_container.dart';
import 'package:job_hub_app/main_views/profile_view/widgets/skill_container.dart';
import 'package:job_hub_app/main_views/update_user_view/update_user_view.dart';
import 'package:job_hub_app/widgets/custom_app_bar.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (context) => GetUserCubit()..getUserData(),
      child: Scaffold(
        body: BlocBuilder<GetUserCubit, GetUserState>(
          builder: (context, state) {
            GetUserCubit cubit = BlocProvider.of<GetUserCubit>(context);
            if (state is GetUserLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            return SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      HomeAppBar(title: 'Profile'),
                      SizedBox(height: screenHeight * .02),
                      Row(
                        children: [
                          Container(
                            width: 90.w,
                            height: 50.h,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.rectangle,
                            ),
                            child:
                                cubit.user?.imageUrl != null &&
                                    cubit.user!.imageUrl!.isNotEmpty
                                ? Image.network(
                                    cubit.user!.imageUrl!,
                                    fit: BoxFit.fill,
                                  )
                                : Icon(Icons.person),
                          ),
                          SizedBox(width: screenWidth * .03),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                cubit.user?.username ?? '',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    size: 20.r,
                                    color: Colors.black.withValues(alpha: .3),
                                  ),
                                  Text(
                                    cubit.user?.location ?? '',
                                    style: TextStyle(
                                      color: Colors.black.withValues(alpha: .3),
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Spacer(),
                          IconButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => UpdateUserView(),
                                ),
                              );
                            },
                            icon: Icon(
                              Icons.edit,
                              size: 15.r,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: screenHeight * .02),
                      ItemContainer(
                        width: 320.w,
                        height: 90.h,
                        child: Row(
                          children: [
                            Container(
                              width: 55.w,
                              height: 60.h,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.rectangle,
                              ),
                            ),
                            SizedBox(width: screenWidth * .05),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "${cubit.user?.username}'s Resume",
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "JobHub Resume",
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black.withValues(alpha: .3),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      ItemContainer(
                        width: 320.w,
                        height: 40.h,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            cubit.user?.email ?? '',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      ItemContainer(
                        width: 320.w,
                        height: 40.h,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              Icon(
                                Icons.phone_android_sharp,
                                size: 20.r,
                                color: Colors.black,
                              ),
                              SizedBox(width: screenWidth * .02),
                              Text(
                                cubit.user?.phone ?? '',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      ItemContainer(
                        width: 320.w,
                        height: 350.h,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Skills',
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              ...(cubit.user?.skills ?? [])
                                  .map(
                                    (skill) => SkillContainer(skillName: skill),
                                  )
                                  .toList(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
