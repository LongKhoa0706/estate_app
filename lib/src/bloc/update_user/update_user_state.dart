part of 'update_user_bloc.dart';

@immutable
abstract class UpdateUserState {}

class InitialUpdateUserState extends UpdateUserState {}

class UpdateUserStateLoading extends UpdateUserState{}

class UpdateUserStateFail extends UpdateUserState{
  final dynamic error;

  UpdateUserStateFail(this.error);

}

class UpdateUserStateSuccess extends UpdateUserState {}