part of 'create_job_cubit.dart';

@immutable
sealed class CreateJobState {}

final class CreateJobInitial extends CreateJobState {}
final class CreateJobLoading extends CreateJobState {}
final class CreateJobSuccess extends CreateJobState{
  final CreateJobResponse response;
  CreateJobSuccess(this.response);
  }
final class CreateJobFailure extends CreateJobState{
  final String error;
  CreateJobFailure(this.error);
}
final class RequirementUpdated extends CreateJobState {
  final List<String> requirements;
  RequirementUpdated(this.requirements);
}
