part of 'comment_bloc.dart';

@immutable
abstract class CommentState {}

class CommentInitial extends CommentState {}

class LoadingComment extends CommentState {}


class FetchedComment extends CommentState {
  final CommentModel comments;
  FetchedComment({required this.comments});
}

class CommentError extends CommentState {
  final String message;
  CommentError({required this.message});
}