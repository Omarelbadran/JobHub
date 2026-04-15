import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_hub_app/auth_views/change_password_view/change_password_view.dart';
import 'package:job_hub_app/main_views/delete_account_view/delete_account_view.dart';
import 'package:job_hub_app/main_views/user_settings_view/widgets/user_settings_item.dart';
import 'package:job_hub_app/widgets/custom_app_bar.dart';
class UserSettingsView extends StatelessWidget {
  const UserSettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    return  Scaffold(
      body: SafeArea(
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: 12.w),
            child: Column(
            children: [
              const CustomAppBar(title: 'settings'),
              SizedBox(height: screenHeight * .02,),
              UserSettingItem(
                onTap: (){
                  Navigator.of(context).push(

                      MaterialPageRoute(builder: (context) => ChangePasswordView()
                      ),
                  );
                },
                  title: 'Change Password',
                  subTitle: 'Change your Password',
                  icon: Icons.lock_outline_sharp,
              ),
              SizedBox(height: screenHeight * .02,),
              UserSettingItem(
                onTap: (){
                  Navigator.of(context).push(

                    MaterialPageRoute(builder: (context) => DeleteAccountView()
                    ),
                  );
                },
                title: 'Delete Account',
                subTitle: 'Delete your Password',
                icon: Icons.delete_sweep_outlined,
              ),
              SizedBox(height: screenHeight * .02,),
              UserSettingItem(
                title: 'Log Out',
                subTitle: 'Log out of your Password',
                icon: Icons.logout,
              ),
              SizedBox(height: screenHeight * .02,),
              UserSettingItem(
                title: 'App Version',
                subTitle: '1.0.0',
                icon: Icons.info_outline,
              ),
            ],
            ),
          ),
      ),
    );
  }
}
