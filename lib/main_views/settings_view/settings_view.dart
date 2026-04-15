import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_hub_app/main_views/admin_panel_view/admin_panel_view.dart';
import 'package:job_hub_app/main_views/settings_view/widgets/setting_item.dart';
import 'package:job_hub_app/widgets/custom_app_bar.dart';

import '../home_view/widgets/home_app_bar.dart';
class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 12.w),
          child: Column(
            children: [
              HomeAppBar(title: 'Settings',),
              SizedBox(height: screenHeight * .01,),
              SettingItem(
                onTap: (){
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => AdminPanelView(),
                  ),
                  );
                },
                title: 'Admin Panel',
                subTitle: 'Manage your app',
                icon: Icons.admin_panel_settings_outlined,
              ),
              SizedBox(height: screenHeight * .02,),
              SettingItem(title: 'Log Out',
                subTitle: 'log out of your account',
                icon: Icons.logout_sharp,
              ),
              SizedBox(height: screenHeight * .02,),
              SettingItem(title: 'App Version',
                subTitle: '1.0.0',
                icon: Icons.info_outline,
              ),
            ],
          ),
        ),
      )
    );
  }
}
