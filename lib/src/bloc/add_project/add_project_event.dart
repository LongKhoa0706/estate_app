part of 'add_project_bloc.dart';

@immutable
abstract class AddProjectEvent {}

class AddProjectEventSubmit extends AddProjectEvent{

  final Project project;
  final File urlImageLogo;
  final List<Asset> listImageProject;

  AddProjectEventSubmit(this.project, this.urlImageLogo, this.listImageProject);


}
