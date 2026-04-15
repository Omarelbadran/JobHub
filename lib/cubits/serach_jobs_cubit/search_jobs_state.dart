part of 'search_jobs_cubit.dart';

@immutable
sealed class SearchJobsState {}

final class SearchJobsInitial extends SearchJobsState {}

final class SearchJobsLoading extends SearchJobsState {}

final class SearchJobsSuccess extends SearchJobsState {
  final List<JobModel> jobs;

  SearchJobsSuccess(this.jobs);
}

final class SearchJobsEmpty extends SearchJobsState {}

final class SearchJobsFailure extends SearchJobsState {
  final String error;

  SearchJobsFailure(this.error);
}

