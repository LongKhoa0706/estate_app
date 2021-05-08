part of 'project_lease_bloc.dart';

@immutable
abstract class ProjectLeaseEvent {}

class ProjectLeaseEventFetchData extends ProjectLeaseEvent{
  final String type;

  ProjectLeaseEventFetchData(this.type);

}