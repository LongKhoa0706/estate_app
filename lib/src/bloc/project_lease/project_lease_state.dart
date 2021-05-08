part of 'project_lease_bloc.dart';

@immutable
abstract class ProjectLeaseState {}


class InitialProjectLeaseState extends ProjectLeaseState {}

class ProjectLeaseStateLoading extends ProjectLeaseState{}

class ProjectLeaseStateSuccess extends ProjectLeaseState{
  final List<Project> listProject;

  ProjectLeaseStateSuccess(this.listProject);

}

class ProjectLeaseStateFail extends ProjectLeaseState{
  final dynamic error;

  ProjectLeaseStateFail(this.error);

}