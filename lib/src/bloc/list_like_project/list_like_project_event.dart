part of 'list_like_project_bloc.dart';

@immutable
abstract class ListLikeProjectEvent {}

class ListLikeProjectEventFetchData extends ListLikeProjectEvent {
  final int idProject;

  ListLikeProjectEventFetchData(this.idProject);
}