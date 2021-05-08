part of 'comment_post_bloc.dart';

@immutable
abstract class CommentPostState {}

class InitialCommentPostState extends CommentPostState {}

class CommentPostStateLoading extends CommentPostState{}

class CommentPostStateFail extends CommentPostState{
  final dynamic error;

  CommentPostStateFail(this.error);
}
class CommentPostStateSuccess extends CommentPostState{}
