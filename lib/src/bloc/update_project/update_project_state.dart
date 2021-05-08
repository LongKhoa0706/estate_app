part of 'update_project_bloc.dart';

@immutable
abstract class UpdateProjectState {}

class InitialUpdateProjectState extends UpdateProjectState {}

class UpdateProjectStateLoading extends UpdateProjectState{}

class UpdateProjectStateFail extends UpdateProjectState{
  final dynamic error;

  UpdateProjectStateFail(this.error);
}

class UpdateProjectStateSuccess extends UpdateProjectState{

}