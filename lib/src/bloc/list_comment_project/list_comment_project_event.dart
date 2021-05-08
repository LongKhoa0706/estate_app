part of 'list_comment_project_bloc.dart';

@immutable
abstract class ListCommentProjectEvent {}

class ListCommentProjectEventFetch extends ListCommentProjectEvent{
  final int idProject;

  ListCommentProjectEventFetch(this.idProject);

}