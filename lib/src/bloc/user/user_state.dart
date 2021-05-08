part of 'user_bloc.dart';

@immutable
abstract class UserState {}

class InitialUserState extends UserState {}

class UserStateFail extends UserState{
  final dynamic error;

  UserStateFail(this.error);

}

class UserStateLoading extends UserState {

}

class UserStateSuccess extends UserState{
  final Users user;
   int idUser;
  UserStateSuccess(this.user, this.idUser);

}