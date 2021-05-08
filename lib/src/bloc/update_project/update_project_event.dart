part of 'update_project_bloc.dart';

@immutable
abstract class UpdateProjectEvent {}

class UpdateProjectEventSubmit extends UpdateProjectEvent{
  final int idProject;
  final Project project;

  UpdateProjectEventSubmit(this.idProject, this.project);
}
