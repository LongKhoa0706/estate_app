part of 'comment_project_bloc.dart';

@immutable
abstract class CommentProjectState {}

class InitialCommentProjectState extends CommentProjectState {}

class CommentProjectStateLoading extends CommentProjectState{}

class CommentProjectStateSuccess extends CommentProjectState{}

class CommentProjectStateFail extends CommentProjectState{
  final dynamic error;

  CommentProjectStateFail(this.error);

}