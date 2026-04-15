part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}
class ChangeObscure extends LoginState {}
class LoginLoading extends LoginState {}
class LoginSuccess extends LoginState {
  final LoginResponse response;
  LoginSuccess(this.response);
}
class LoginFailure extends LoginState {
  final String error;
  LoginFailure(this.error);
}