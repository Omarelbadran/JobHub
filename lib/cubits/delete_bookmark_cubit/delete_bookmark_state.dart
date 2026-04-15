part of 'delete_bookmark_cubit.dart';

@immutable
sealed class DeleteBookmarkState {}

final class DeleteBookmarkInitial extends DeleteBookmarkState {}
class DeleteBookmarkLoading extends DeleteBookmarkState {}

class DeleteBookmarkFailure extends DeleteBookmarkState {
  final String errorMessage;
  DeleteBookmarkFailure(this.errorMessage);
}

class DeleteBookmarkSuccess extends DeleteBookmarkState {
  final DeleteBookmarkResponse response;
  DeleteBookmarkSuccess(this.response);
}

