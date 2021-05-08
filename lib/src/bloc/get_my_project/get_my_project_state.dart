part of 'get_my_project_bloc.dart';

@immutable
abstract class GetMyProjectState {}

class InitialGetMyProjectState extends GetMyProjectState {}

class GetMyProjectStateFail extends GetMyProjectState{
  final dynamic error;

  GetMyProjectStateFail(this.error);

}

class GetMyProjectStateSuccess extends GetMyProjectState{
 final  List<Project> listMyProject;

  GetMyProjectStateSuccess(this.listMyProject);
}
class GetMyProjectStateLoading extends GetMyProjectState{

}