part of 'get_user_cubit.dart';

@immutable
sealed class GetUserState {}

final class GetUserInitial extends GetUserState {}
final class GetUserLoading extends GetUserState{}
final class GetUserSuccess extends GetUserState {
  final GetUserResponse response;
  GetUserSuccess(this.response);
}
final class GetUserFailure extends GetUserState {
  final String error;
  GetUserFailure(this.error);
}

