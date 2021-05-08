part of 'list_like_comment_bloc.dart';

@immutable
abstract class ListLikeCommentEvent {}

class ListLikeCommentEventFetching extends ListLikeCommentEvent {
  final int idComment;

  ListLikeCommentEventFetching(this.idComment);

}