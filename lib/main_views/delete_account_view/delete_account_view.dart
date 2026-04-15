import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_text_form_field.dart';
class DeleteAccountView extends StatelessWidget {
  const DeleteAccountView({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.arrow_back_ios_new,color: Colors.black,),
        title: Text('Change Password',
          style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 20.w,vertical: 50.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Delete Account!',
                style: TextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height: screenHeight * .015,),
              Text('Fill the details to delete your account',
                style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black.withValues(alpha: .4)
                ),
              ),
              SizedBox(height: screenHeight * .02,),
              CustomTextFormField(
                  suffixIcon: Icon(Icons.visibility_outlined),
                  prefixIcon: Icons.lock_outline_sharp,
                  hintText: 'Password'
              ),
              SizedBox(height: screenHeight * .015,),
              CustomElevatedButton(
                  onPressed: (){},
                  butName: 'Delete Account'
              )
            ],
          ),
        ),
      ),
    );
  }
}
