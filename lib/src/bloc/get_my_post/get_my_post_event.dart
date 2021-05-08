part of 'get_my_post_bloc.dart';

@immutable
abstract class GetMyPostEvent {}

class GetMyPostEventFetch extends GetMyPostEvent{
  final int idUser;

  GetMyPostEventFetch(this.idUser);

}