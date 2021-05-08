part of 'list_comment_project_bloc.dart';

@immutable
abstract class ListCommentProjectState {}

class InitialListCommentProjectState extends ListCommentProjectState {}

class ListCommentProjectStateLoading extends ListCommentProjectState{

}
class ListCommentProjectStateSuccess extends ListCommentProjectState{
  final List<Comment> listComment;

  ListCommentProjectStateSuccess(this.listComment);
}
class ListCommentProjectStateFail extends ListCommentProjectState{
  final dynamic error;

  ListCommentProjectStateFail(this.error);

}