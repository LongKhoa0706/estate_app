part of 'get_all_project_bloc.dart';

@immutable
abstract class GetAllProjectState {}

class InitialGetAllProjectState extends GetAllProjectState {}

class GetAllProjectStateLoading extends GetAllProjectState{}
class GetAllProjectStateSuccess extends GetAllProjectState{
  final List<Project> listProject;

  GetAllProjectStateSuccess(this.listProject);
}
class GetAllProjectStateFail extends GetAllProjectState{
  final dynamic error;

  GetAllProjectStateFail(this.error);

}
