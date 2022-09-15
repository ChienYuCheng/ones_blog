import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:ones_blog/repository/comment_repo.dart';

import '../model/comment_model.dart';

part 'comment_event.dart';
part 'comment_state.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  final CommentRepository commentRepo;
  CommentBloc(this.commentRepo) : super(CommentInitial());

  @override
  Stream<CommentState> mapEventToState(CommentEvent event) async* {
    if (event is FetchCommentEvent) {
      yield LoadingComment();
      try {
        CommentModel comments = await commentRepo.fetchComment();
        yield FetchedComment(comments: comments);
      } catch (e) {
        yield CommentError(message: e.toString());
      }
    }
  }
}
