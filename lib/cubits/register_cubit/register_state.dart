part of 'register_cubit.dart';

@immutable
sealed class RegisterState {}

final class RegisterInitial extends RegisterState {}

class ChangeObscure extends RegisterState{}
class RegisterLoading extends RegisterState{}
class RegisterSuccess extends RegisterState{
  final RegisterResponse response;
  RegisterSuccess(this.response);
}
class RegisterFailure extends RegisterState{
  final String error;
  RegisterFailure(this.error);
}