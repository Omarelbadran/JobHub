import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_hub_app/main_views/manage_user_view/manage_user_view.dart';
import 'package:job_hub_app/main_views/settings_view/widgets/setting_item.dart';
import 'package:job_hub_app/widgets/settings_app_bar.dart';

import '../manage_jobs_view/manage_jobs_view.dart';
class AdminPanelView extends StatelessWidget {
  const AdminPanelView({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 12.w),
          child: Column(
            children: [
              SettingsAppBar(
                title: 'Admin Panel',
                onPressed: (){
                  Navigator.of(context).pop();
                },
              ),
              SizedBox(height: screenHeight * .01,),
              SettingItem(
                  onTap: (){
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => ManageUserView(),
                    ),
                    );
                  },
                  title: 'App users'
                  , subTitle: 'Manage app users',
                  icon: Icons.supervised_user_circle_outlined
              ),
              SizedBox(height: screenHeight * .02,),
              SettingItem(
                  onTap: (){
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => ManageJobsView(),
                    ),
                    );
                  },
                  title: 'App jobs'
                  , subTitle: 'Manage app jobs',
                  icon: Icons.card_travel
              ),
            ],
          ),
        ),
      )
    );
  }
}
