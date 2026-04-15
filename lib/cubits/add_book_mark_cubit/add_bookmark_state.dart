part of 'add_bookmark_cubit.dart';

@immutable
sealed class AddBookmarkState {}

class AddBookmarkInitial extends AddBookmarkState {}

class AddBookmarkLoading extends AddBookmarkState {}

class AddBookmarkSuccess extends AddBookmarkState {
  final AddBookmarkResponse response;

  AddBookmarkSuccess(this.response);
}

class AddBookmarkFailure extends AddBookmarkState {
  final String error;

  AddBookmarkFailure(this.error);
}
