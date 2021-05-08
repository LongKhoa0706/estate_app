part of 'add_project_bloc.dart';

@immutable
abstract class AddProjectState {}

class InitialAddProjectState extends AddProjectState {}

class AddProjectStateLoading extends AddProjectState{

}

class AddProjectStateSuccess extends AddProjectState{

}

class AddProjectStateFail extends AddProjectState{
  final dynamic error;

  AddProjectStateFail(this.error);

}
