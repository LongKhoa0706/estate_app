part of 'get_my_project_bloc.dart';

@immutable
abstract class GetMyProjectEvent {}

class GetMyProjectEventFetching extends GetMyProjectEvent{
  final int idUser;

  GetMyProjectEventFetching(this.idUser);

}