import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../api/api_errors.dart';
import '../../models/login/login_request.dart';
import '../../models/login/login_response.dart';
import '../../repos/auth_repo.dart';



part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  bool isObscure = true;
  bool isLogin = false;
  Icon suffix = Icon(
    Icons.visibility_outlined,
    size: 22.sp,
    color: Colors.grey[600],
  );

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();
  @override
  Future<void> close() async {
    emailController.dispose();
    passwordController.dispose();
    return await super.close();
  }

  void changeObscure() {
    isObscure = !isObscure;
    isObscure
        ? suffix = Icon(
      Icons.visibility_outlined,
      size: 22.sp,
      color: Colors.grey[600],
    )
        : suffix = Icon(
      Icons.visibility_off_outlined,
      size: 22.sp,
      color: Colors.grey[600],
    );
    emit(ChangeObscure());
  }

  Future<void> login() async {
    emit(LoginLoading());
    try {
      var response = await AuthRepo.login(
          LoginRequest(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      ));
      emit(LoginSuccess(response));
      print("====================token============================");
      print(  response.token);
      final prefs = await SharedPreferences.getInstance();
      if (response.userData != null) {
        await prefs.setString('userData', jsonEncode(response.userData!.toJson()));
        await prefs.setBool('isAdmin', response.userData!.isAdmin ?? false);
        await prefs.setString('userId', response.userData!.id ?? "");
      }
      await prefs.setString('token', response.token.toString());
      print(prefs.getString("token"));
      isLogin=true;
      print("====================token============================");
    } on Exception catch (e) {
      String errorMessage = APIError.getErrorMessage(e);
      isLogin=false;
      emit(LoginFailure(errorMessage));
    }
  }
}