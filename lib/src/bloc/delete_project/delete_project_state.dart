part of 'delete_project_bloc.dart';

@immutable
abstract class DeleteProjectState {}

class InitialDeleteProjectState extends DeleteProjectState {}

class DeleteProjectStateLoading extends DeleteProjectState{}

class DeleteProjectStateSuccess extends DeleteProjectState{}

class DeleteProjectStateFail extends DeleteProjectState{}
