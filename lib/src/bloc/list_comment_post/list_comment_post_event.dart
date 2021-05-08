part of 'list_comment_post_bloc.dart';

@immutable
abstract class ListCommentPostEvent {}

class ListCommentPostEventFetchData extends ListCommentPostEvent{
  final int postId;

  ListCommentPostEventFetchData(this.postId);

}