part of 'detail_project_bloc.dart';

@immutable
abstract class DetailProjectEvent {}

class DetailProjectEventFetching extends DetailProjectEvent{
  final int idProject;

  DetailProjectEventFetching(this.idProject);
}