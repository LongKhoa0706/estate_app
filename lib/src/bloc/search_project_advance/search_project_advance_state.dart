part of 'search_project_advance_bloc.dart';

@immutable
abstract class SearchProjectAdvanceState {}

class InitialSearchProjectAdvanceState extends SearchProjectAdvanceState {}

class SearchProjectAdvanceStateLoading extends SearchProjectAdvanceState{

}
class SearchProjectAdvanceStateSuccess extends SearchProjectAdvanceState{
  final List<Project> listResultProject;

  SearchProjectAdvanceStateSuccess(this.listResultProject);

}
class SearchProjectAdvanceStateFail extends SearchProjectAdvanceState{
  final dynamic error;

  SearchProjectAdvanceStateFail(this.error);
}