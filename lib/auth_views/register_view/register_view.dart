import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_hub_app/auth_views/complete_info_view/complete_info_view.dart';
import 'package:job_hub_app/auth_views/login_view/login_view.dart';
import 'package:job_hub_app/auth_views/register_view/register_view.dart';
import 'package:job_hub_app/cubits/register_cubit/register_cubit.dart';
import 'package:job_hub_app/widgets/custom_elevated_button.dart';
import 'package:job_hub_app/widgets/custom_text_form_field.dart';

import '../../functions/show_snack_bar.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    return BlocProvider<RegisterCubit>(
      create: (context) => RegisterCubit(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          title: const Text(
            'Register',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: BlocConsumer<RegisterCubit, RegisterState>(
          listener: (context, state) {
            if (state is RegisterFailure) {
              showCustomSnackBar(context, state.error);
            }
          },
          builder: (context, state) {
            RegisterCubit cubit = BlocProvider.of<RegisterCubit>(context);
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 30.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome to Job-Hub!',
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: screenHeight * .005),
                  Text(
                    'Fill the details to login to your account.',
                    style: TextStyle(
                      color: Colors.black.withValues(alpha: .4),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: screenHeight * .05),
                  CustomTextFormField(
                    autofillHints: const [AutofillHints.username],
                    controller: cubit.userNameController,
                    prefixIcon: Icons.person,
                    hintText: 'Username',
                  ),
                  SizedBox(height: screenHeight * .02),
                  CustomTextFormField(
                    autofillHints: const [AutofillHints.email],
                    controller: cubit.emailController,
                    prefixIcon: Icons.email_outlined,
                    hintText: 'Email',
                  ),
                  SizedBox(height: screenHeight * .02),
                  CustomTextFormField(
                    prefixIcon: Icons.lock_outline,
                    autofillHints: const [AutofillHints.password],
                    controller: cubit.passwordController,
                    obscureText: cubit.isObscure,
                    hintText: 'Password',
                    suffixIcon: GestureDetector(
                      onTap: () {
                        cubit.changeObscure();
                      },
                      child: cubit.suffix,
                    ),
                  ),
                  SizedBox(height: screenHeight * .025),
                  Align(
                    alignment: Alignment.centerRight,
                    child: RichText(
                      text: TextSpan(
                        text: "Already have account? ",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          fontSize: 14.sp,
                        ),
                        children: [
                          TextSpan(
                            text: 'login!',
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => LoginView(),
                                  ),
                                );
                              },
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * .025),
                  CustomElevatedButton(
                        butName: 'Complete Info',
                        onPressed: () {
                          if (
                          cubit.userNameController.text.isNotEmpty &&
                              cubit.emailController.text.isNotEmpty
                          && cubit.passwordController.text.isNotEmpty
                          ) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BlocProvider.value(
                                  value: cubit,
                                  child: const CompleteInfoView(),
                                ),
                              ),
                            );
                          } else {
                            showCustomSnackBar(context, "Please fill your basic info first");
                          }
                        },
                      ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
