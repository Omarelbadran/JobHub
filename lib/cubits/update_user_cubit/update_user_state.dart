part of 'update_user_cubit.dart';

@immutable
sealed class UpdateUserState {}

final class UpdateUserInitial extends UpdateUserState {}
final class UpdateUserLoading extends UpdateUserState {}
final class UpdateUserSuccess extends UpdateUserState {
  final UpdateUserResponse response;
  UpdateUserSuccess(this.response);
}
final class UpdateUserFailure extends UpdateUserState{
  final String error;
  UpdateUserFailure(this.error);
}
class SkillsUpdated extends UpdateUserState {}

class ResumePicked extends UpdateUserState {
  final String fileName;

  ResumePicked(this.fileName);
}
class ProfileImagePicked extends UpdateUserState {
  final String imageName;
  ProfileImagePicked(this.imageName);
}
