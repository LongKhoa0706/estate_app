part of 'list_reply_comment_bloc.dart';

@immutable
abstract class ListReplyCommentState {}

class InitialListReplyCommentState extends ListReplyCommentState {}

class ListReplyCommentStateLoading extends ListReplyCommentState{}

class ListReplyCommentStateSuccess extends ListReplyCommentState{
 final List<Comment> listReplyComment;

  ListReplyCommentStateSuccess(this.listReplyComment);

}

class ListReplyCommentStateFail extends ListReplyCommentState{
  final dynamic error;

  ListReplyCommentStateFail(this.error);

}