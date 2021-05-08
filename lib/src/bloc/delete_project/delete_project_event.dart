part of 'delete_project_bloc.dart';

@immutable
abstract class DeleteProjectEvent {}

class DeleteProjectEventSubmit extends DeleteProjectEvent{
  final int idProject;

  DeleteProjectEventSubmit(this.idProject);

}
