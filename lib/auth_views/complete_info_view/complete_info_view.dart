import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_hub_app/auth_views/complete_info_view/widgets/country_pick_text_field.dart';
import 'package:job_hub_app/auth_views/complete_info_view/widgets/location_text_form_field.dart';
import 'package:job_hub_app/auth_views/login_view/login_view.dart';
import 'package:job_hub_app/widgets/custom_elevated_button.dart';
import 'package:job_hub_app/widgets/custom_text_form_field.dart';

import '../../cubits/register_cubit/register_cubit.dart';
import '../../functions/show_snack_bar.dart';
class CompleteInfoView extends StatelessWidget {
  const CompleteInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final cubit = context.read<RegisterCubit>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios_new)),
        backgroundColor: Colors.transparent,
        title: Text('Complete Info',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20.sp
        ),
        ),
      ),
      body: BlocConsumer<RegisterCubit, RegisterState>(
  listener: (context, state) {
    if (state is RegisterSuccess) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginView()),
      );
      showCustomSnackBar(context, "Account Created Successfully");
    }
    if (state is RegisterFailure) {
      showCustomSnackBar(context, state.error);
    }
  },
  builder: (context, state) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('PersonalDetails' ,
              style: TextStyle(
                fontSize: 30.sp,
                fontWeight: FontWeight.bold,
              ),
              ),
              SizedBox(height: screenHeight *.01,),
              CountryPickTextField(
                autofillHints: const [AutofillHints.telephoneNumber],
                controller: cubit.phoneController,
                keyboardType: TextInputType.phone,
                onCountryChanged: (country) {
                  cubit.updateCountryCode(country.dialCode!);
                },
              ),
              SizedBox(height: screenHeight *.04,),
              LocationTextFormField(
                autofillHints: const [AutofillHints.location],
                controller: cubit.locationController,
              ),
              SizedBox(height: screenHeight *.01,),
              Text('Professional Skills' ,
                style: TextStyle(
                  fontSize: 30.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: screenHeight *.01,),
              CustomTextFormField(
                controller: cubit.skill1Controller,
                  hintText: 'first skill'
              ),
              SizedBox(height: screenHeight *.01,),
              CustomTextFormField(
                  controller: cubit.skill2Controller,
                  hintText: 'second skill'
              ),
              SizedBox(height: screenHeight *.01,),
              CustomTextFormField(
                  controller: cubit.skill3Controller,
                  hintText: 'third skill'
              ),
              SizedBox(height: screenHeight *.01,),
              CustomTextFormField(
                  controller: cubit.skill4Controller,
                  hintText: 'fourth skill'
              ),
              SizedBox(height: screenHeight *.02,),
              Builder(
                builder: (context) {
                  if (state is RegisterLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return CustomElevatedButton(
                      onPressed: (){
                        if(
                        cubit.phoneController.text.isNotEmpty
                            && cubit.locationController.text.isNotEmpty
                            && cubit.skill1Controller.text.isNotEmpty
                        ){
                          cubit.register();
                        }
                        else{
                          showCustomSnackBar(context, "Please fill in your phone and location and one skill");
                        }
                      },
                      butName: 'Create Account'
                  );
                }
              ),
            ],
          ),
        ),
      );
  },
),
    );
  }
}
