part of 'detail_project_bloc.dart';

@immutable
abstract class DetailProjectState {}

class InitialDetailProjectState extends DetailProjectState {}

class DetailProjectStateLoading extends DetailProjectState{}

class DetailProjectStateSuccess extends DetailProjectState {
  final Project project;
  final Address address;

  DetailProjectStateSuccess(this.project, this.address);
}

class DetailProjectStateFail extends DetailProjectState {
  final dynamic error;

  DetailProjectStateFail(this.error);
}
