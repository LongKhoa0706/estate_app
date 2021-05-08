part of 'search_project_bloc.dart';

@immutable
abstract class SearchProjectState {}

class InitialSearchProjectState extends SearchProjectState {}

class SearchProjectStateLoading extends SearchProjectState{}

class SearchProjectStateSuccess extends SearchProjectState{
  final List<Project> lisSearchProject;

  SearchProjectStateSuccess(this.lisSearchProject);

}

class SearchProjectStateFail extends SearchProjectState{
  final dynamic error;

  SearchProjectStateFail(this.error);

}