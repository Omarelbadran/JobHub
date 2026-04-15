import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_hub_app/auth_views/choose_screen_view/choose_screen_view.dart';

import '../../widgets/custom_text_button.dart';
import '../../widgets/dots_indicator.dart';
class SecondSplashScreenView extends StatelessWidget {
  const SecondSplashScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.indigo,
      body: SafeArea(
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: 14.w),
            child: Column(
              children: [
                Image.asset('assets/images/page2.png', height: 350.h,),
                SizedBox(height: screenHeight * .02 ,),
                Text('Stable yourself' ,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 34.sp,
                      fontWeight: FontWeight.w600
                  ),
                ),
                Text('With your ability' ,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 34.sp,
                      fontWeight: FontWeight.w600
                  ),
                ),
                Text('We help you find your dream job\naccording to your skills,location,\nand preference to build your\ncareer' ,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w400
                  ),
                ),
                SizedBox(height: screenHeight * .01 ,),
                DotsIndicator(currentIndex: 1, dotsCount : 3),
                SizedBox(height: screenHeight * .03 ,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomTextButton(
                        onPressed: (){
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => ChooseScreenView()
                            ),
                          );
                        },
                        butName: 'Next'
                    ),
                    CustomTextButton(
                        onPressed: (){
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => ChooseScreenView()
                            ),
                          );
                        },
                        butName: 'Skip'
                    ),
                  ],
                ),
              ],
            ),
          )
      ),
    );
  }
}
