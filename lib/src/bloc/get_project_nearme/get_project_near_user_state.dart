part of 'get_project_near_user_bloc.dart';

@immutable
abstract class GetProjectNearUserState {}

class GetProjectNearUserInitial extends GetProjectNearUserState {}

class GetProjectNearUserStateLoading extends GetProjectNearUserState{}

class GetProjectNearUserStateSuccess extends GetProjectNearUserState{
  final List<Project> listProject;

  GetProjectNearUserStateSuccess(this.listProject);

}

class GetProjectNearUserFail extends GetProjectNearUserState{
  final dynamic error;

  GetProjectNearUserFail(this.error);

}