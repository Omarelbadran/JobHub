part of 'get_all_users_cubit.dart';

@immutable
sealed class GetAllUsersState {}

final class GetAllUsersInitial extends GetAllUsersState {}
final class GetAllUsersLoading extends GetAllUsersState {}
final class GetAllUsersSuccess extends GetAllUsersState {
  final GetAllUsersResponse response;
  GetAllUsersSuccess(this.response);
}
final class GetAllUsersFailure extends GetAllUsersState {
  final String error;
  GetAllUsersFailure(this.error);
}
