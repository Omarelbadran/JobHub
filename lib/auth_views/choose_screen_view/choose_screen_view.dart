import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_hub_app/auth_views/choose_screen_view/widgets/auth_button.dart';
import 'package:job_hub_app/auth_views/login_view/login_view.dart';

import '../register_view/register_view.dart';
class ChooseScreenView extends StatelessWidget {
  const ChooseScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Column(
        children: [
          Image.asset('assets/images/page3.png'),
          SizedBox(height: screenHeight *.02,),
          Text('Find Your Dream Job' ,
          style: TextStyle(
              color: Colors.white,
              fontSize: 34.sp,
              fontWeight: FontWeight.w600
          ),
          ),
          Text('We help you find your dream job\naccording to your skills,location,\nand preference to build your career' ,
            style: TextStyle(
                color: Colors.white,
                fontSize: 20.sp,
                fontWeight: FontWeight.w400
            ),
          ),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 12.w, vertical: 24.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AuthButton(
                  buttonColor: Colors.blueAccent,
                    onPressed: (){
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => LoginView()
                      ),
                    );
                    },
                    butName : 'Login',
                  textColor: Colors.white,
                ),
                AuthButton(
                  buttonColor: Colors.white,
                  onPressed: (){
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => RegisterView()
                      ),
                    );
                  },
                  butName : 'Register',
                  textColor: Colors.blueAccent,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
