import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_hub_app/auth_views/second_splash_screen_view/second_splash_screen_view.dart';
import 'package:job_hub_app/widgets/custom_text_button.dart';
import 'package:job_hub_app/widgets/dots_indicator.dart';
class FirstSplashScreenView extends StatelessWidget {
  const FirstSplashScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: SafeArea(
        child: Column(
          children: [
            Image.asset('assets/images/page1.png'),
            SizedBox(height: screenHeight * .04 ,),
            Text('Find Your Dream Job' ,
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
            DotsIndicator(currentIndex: 0, dotsCount : 3),
            SizedBox(height: screenHeight * .03 ,),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 10.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomTextButton(
                      onPressed: (){
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => SecondSplashScreenView()
                          ),
                        );
                      },
                      butName: 'Next'
                  ),
                  CustomTextButton(
                      onPressed: (){},
                      butName: 'Skip'
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
