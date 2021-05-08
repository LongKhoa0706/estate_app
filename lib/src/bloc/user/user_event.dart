part of 'user_bloc.dart';

@immutable
abstract class UserEvent {}

class UserEventFetchData extends UserEvent {

}

class UserEventFetchDetailData extends UserEvent{
  final int idUser;

  UserEventFetchDetailData(this.idUser);

}
