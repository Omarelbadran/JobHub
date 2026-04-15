import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_hub_app/auth_views/register_view/register_view.dart';
import 'package:job_hub_app/cubits/login_cubit/login_cubit.dart';
import 'package:job_hub_app/main_views/home_view/home_view.dart';
import 'package:job_hub_app/widgets/custom_elevated_button.dart';
import 'package:job_hub_app/widgets/custom_text_form_field.dart';
import '../../functions/show_snack_bar.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    return BlocProvider<LoginCubit>(
      create: (context) => LoginCubit(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          title: const Text(
            'Login',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: BlocConsumer<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state is LoginSuccess) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HomeView()),
              );

              showCustomSnackBar(context, "Login Successful");
            }
            if (state is LoginFailure) {
              showCustomSnackBar(context, state.error);
            }
          },
          builder: (context, state) {
            LoginCubit cubit = BlocProvider.of<LoginCubit>(context);
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 30.h),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome Back!',
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
                      autofillHints: const [AutofillHints.email],
                      controller: cubit.emailController,
                      prefixIcon: Icons.email_outlined,
                      hintText: 'Email',
                    ),
                    SizedBox(height: screenHeight * .02),
                    CustomTextFormField(
                      autofillHints: const [AutofillHints.password],
                      controller: cubit.passwordController,
                      obscureText: cubit.isObscure,
                      prefixIcon: Icons.lock_outline,
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
                          text: "Don't have account? ",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            fontSize: 14.sp,
                          ),
                          children: [
                            TextSpan(
                              text: 'Register!',
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => RegisterView(),
                                    ),
                                  );
                                },
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * .025),
                    Builder(
                      builder: (context) {
                        if (state is LoginLoading) {
                          return const Center(child: CircularProgressIndicator());
                        }
                        return CustomElevatedButton(
                          butName: 'Login',
                          onPressed: () async {
                            await cubit.login();
                          },
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
