part of 'update_job_cubit.dart';

@immutable
sealed class UpdateJobState {}

final class UpdateJobInitial extends UpdateJobState {}

final class UpdateJobLoading extends UpdateJobState {}

final class UpdateJobSuccess extends UpdateJobState {
  final JobModel updatedJob;

  UpdateJobSuccess(this.updatedJob);
}

final class UpdateJobFailure extends UpdateJobState {
  final String error;

  UpdateJobFailure(this.error);
}