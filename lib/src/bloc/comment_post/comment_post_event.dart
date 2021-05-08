part of 'comment_post_bloc.dart';

@immutable
abstract class CommentPostEvent {}

class CommentPostEventSubmit extends CommentPostEvent {
  final int idProject;
  final String commentContent;
  final int idComment;
  final String typeComment;


  CommentPostEventSubmit(this.idProject, this.commentContent, this.idComment, this.typeComment);

}
