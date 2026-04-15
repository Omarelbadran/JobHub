import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../api/api_errors.dart';
import '../../models/register/register_request.dart';
import '../../models/register/register_response.dart';
import '../../repos/auth_repo.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController skill1Controller = TextEditingController();
  TextEditingController skill2Controller = TextEditingController();
  TextEditingController skill3Controller = TextEditingController();
  TextEditingController skill4Controller = TextEditingController();
  String countryCode = "+20";
  bool isObscure = true;
  Icon suffix = Icon(
    Icons.visibility_outlined,
    color: Colors.grey[600],
    size: 22,
  );
  var formKey = GlobalKey<FormState>();

  void updateCountryCode(String code) {
    countryCode = code;
  }

  @override
  Future<void> close() async {
    emailController.dispose();
    passwordController.dispose();
    userNameController.dispose();
    locationController.dispose();
    phoneController.dispose();
    skill1Controller.dispose();
    skill2Controller.dispose();
    skill3Controller.dispose();
    skill4Controller.dispose();
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

  Future<void> register() async {
    emit(RegisterLoading());
    try {
      List<String> skillsList = [];
      if (skill1Controller.text.isNotEmpty)
        skillsList.add(skill1Controller.text.trim());
      if (skill2Controller.text.isNotEmpty)
        skillsList.add(skill2Controller.text.trim());
      if (skill3Controller.text.isNotEmpty)
        skillsList.add(skill3Controller.text.trim());
      if (skill4Controller.text.isNotEmpty)
        skillsList.add(skill4Controller.text.trim());

      String rawPhone = phoneController.text.trim();
      if (rawPhone.startsWith('0')) {
        rawPhone = rawPhone.substring(1);
      }
      String finalFullPhone = "$countryCode$rawPhone";
      final request = RegisterRequest(
        username: userNameController.text.trim(),
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
        location: locationController.text.trim(),
        phone: finalFullPhone,
        skills: skillsList,
      );
      var response = await AuthRepo.register(request);
      emit(RegisterSuccess(response));
    } catch (e) {
      if (e is DioException) {
        print("Server response: ${e.response?.data}");
      }
      emit(RegisterFailure('Bad Request: ${e.toString()}'));
    }
  }
}
