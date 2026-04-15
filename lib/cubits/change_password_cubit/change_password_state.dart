part of 'change_password_cubit.dart';

@immutable
sealed class ChangePasswordState {}

final class ChangePasswordInitial extends ChangePasswordState {}

class ChangePasswordLoading extends ChangePasswordState {}

class ChangePasswordSuccess extends ChangePasswordState {
  final ChangePasswordResponse response;

  ChangePasswordSuccess(this.response);
}

class ChangePasswordFailure extends ChangePasswordState {
  final String errorMessage;

  ChangePasswordFailure(this.errorMessage);
}
class ChangeObscure extends ChangePasswordState {}