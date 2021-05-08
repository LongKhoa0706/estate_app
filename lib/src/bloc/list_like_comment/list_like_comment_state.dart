part of 'list_like_comment_bloc.dart';

@immutable
abstract class ListLikeCommentState {}

class InitialListLikeCommentState extends ListLikeCommentState {}

class ListLikeCommentStateLoading extends ListLikeCommentState{}

class ListLikeCommentStateFail extends ListLikeCommentState{
  final dynamic error;

  ListLikeCommentStateFail(this.error);

}

class ListLikeCommentStateSuccess extends ListLikeCommentState{
  final List<Users> listLikeComment;
  ListLikeCommentStateSuccess(this.listLikeComment);
}