part of 'list_comment_post_bloc.dart';

@immutable
abstract class ListCommentPostState {}

class InitialListCommentPostState extends ListCommentPostState {}

class ListCommentPostStateLoading extends ListCommentPostState{}

class ListCommentPostStateSuccess extends ListCommentPostState {
  final List<Comment> listCommentPost;

  ListCommentPostStateSuccess(this.listCommentPost);
}
class ListCommentPostStateFail extends ListCommentPostState{
  final dynamic error;

  ListCommentPostStateFail(this.error);

}