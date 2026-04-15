import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_hub_app/widgets/custom_elevated_button.dart';
import 'package:job_hub_app/widgets/custom_text_form_field.dart';

import '../../cubits/change_password_cubit/change_password_cubit.dart';
import '../../functions/show_snack_bar.dart';

class ChangePasswordView extends StatelessWidget {
  const ChangePasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (context) => ChangePasswordCubit(),
      child: Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.arrow_back_ios_new, color: Colors.black),
          title: Text(
            'Change Password',
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: BlocConsumer<ChangePasswordCubit, ChangePasswordState>(
          listener: (context, state) {
            if (state is ChangePasswordSuccess) {
              showCustomSnackBar(context, "Password Changed Successfully");
              Navigator.pop(context);
            }
            if (state is ChangePasswordFailure) {
              showCustomSnackBar(context, state.errorMessage);
            }
          },
          builder: (context, state) {
            ChangePasswordCubit cubit = BlocProvider.of<ChangePasswordCubit>(
              context,
            );
            return SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 50.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Change Password!',
                      style: TextStyle(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: screenHeight * .015),
                    Text(
                      'Fill the details to change your password',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black.withValues(alpha: .4),
                      ),
                    ),
                    SizedBox(height: screenHeight * .02),
                    CustomTextFormField(
                      obscureText: cubit.currentPasswordObscure,
                      autofillHints: [AutofillHints.password],
                      controller: cubit.currentPasswordController,
                      suffixIcon: GestureDetector(
                        onTap: () {
                          cubit.changeCurrentObscure();
                        },
                        child: cubit.currentPasswordSuffixIcon,
                      ),
                      prefixIcon: Icons.lock_outline_sharp,
                      hintText: 'Current Password',
                    ),
                    SizedBox(height: screenHeight * .015),
                    CustomTextFormField(
                      obscureText: cubit.newPasswordObscure,
                      autofillHints: [AutofillHints.password],
                      controller: cubit.newPasswordController,
                      suffixIcon: GestureDetector(
                        onTap: () {
                          cubit.changeNewObscure();
                        },
                        child: cubit.newPasswordSuffixIcon,
                      ),
                      prefixIcon: Icons.lock_outline_sharp,
                      hintText: 'New Password',
                    ),
                    SizedBox(height: screenHeight * .02),
                    Builder(
                      builder: (context) {
                        if (state is ChangePasswordLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return CustomElevatedButton(
                          onPressed: () {
                            cubit.changePassword();
                          },
                          butName: 'Change Password',
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
