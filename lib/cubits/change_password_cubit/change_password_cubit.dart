import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../api/api_errors.dart';
import '../../models/change_password/change_password_request.dart';
import '../../models/change_password/change_password_response.dart';
import '../../repos/auth_repo.dart';

part 'change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  ChangePasswordCubit() : super(ChangePasswordInitial());
  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();

  @override
  Future<void> close() async {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    return await super.close();
  }
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool currentPasswordObscure = true;
  Icon currentPasswordSuffixIcon = Icon(
    Icons.visibility_outlined,
    size: 22.sp,
    color: Colors.grey[600],
  );
void changeCurrentObscure(){
  currentPasswordObscure = !currentPasswordObscure;
  currentPasswordObscure ? currentPasswordSuffixIcon = Icon(
    Icons.visibility_outlined,
    size: 22.sp,
    color: Colors.grey[600],
  ): currentPasswordSuffixIcon = Icon(
    Icons.visibility_off_outlined,
    size: 22.sp,
    color: Colors.grey[600],
  );
  emit(ChangeObscure());
}
bool newPasswordObscure = true;
Icon newPasswordSuffixIcon = Icon(
  Icons.visibility_outlined,
  size: 22.sp,
  color: Colors.grey[600],
);
void changeNewObscure(){
  newPasswordObscure = !newPasswordObscure;
newPasswordObscure ? newPasswordSuffixIcon = Icon(
  Icons.visibility_outlined,
  size: 22.sp,
  color: Colors.grey[60],
): newPasswordSuffixIcon = Icon(
  Icons.visibility_off_outlined,
  size: 22.sp,
  color: Colors.grey[60],
);
emit(ChangeObscure());
}
Future<void> changePassword() async {
  emit(ChangePasswordLoading());
  try {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token == null) {
      throw Exception('Token not found in SharedPreferences');
    }
   final request = ChangePasswordRequest(
      currentPassword: currentPasswordController.text.trim(),
      newPassword: newPasswordController.text.trim(),
    );
    var response = await AuthRepo.changePassword(request,token);
    emit(ChangePasswordSuccess(response));
  } on Exception catch (e) {
    String errorMessage = APIError.getErrorMessage(e);
    emit(ChangePasswordFailure(errorMessage));
  }
}


}
