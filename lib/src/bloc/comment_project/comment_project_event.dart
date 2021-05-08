part of 'comment_project_bloc.dart';

@immutable
abstract class CommentProjectEvent {}

class CommentProjectEventSubmit extends CommentProjectEvent{
  final int idProject;
  final String commentContent;
  final int idComment;


  CommentProjectEventSubmit(this.idProject, this.commentContent, this.idComment);
}