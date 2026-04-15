part of 'get_all_jobs_cubit.dart';

@immutable
sealed class GetAllJobsState {}

final class GetAllJobsInitial extends GetAllJobsState {}
final class GetAllJobsLoading extends GetAllJobsState {}
final class GetAllJobsSuccess extends GetAllJobsState {
  final GetAllJobsResponse response;

  GetAllJobsSuccess(this.response);
}
final class GetAllJobsFailure extends GetAllJobsState {
  final String error;

  GetAllJobsFailure(this.error);
}
