part of 'list_reply_comment_bloc.dart';

@immutable
abstract class ListReplyCommentEvent {}

class ListReplyCommentEventFetchData extends ListReplyCommentEvent{
  final int idProject;
  final int idComment;

  ListReplyCommentEventFetchData(this.idProject, this.idComment);

}
