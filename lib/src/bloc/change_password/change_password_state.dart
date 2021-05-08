part of 'change_password_bloc.dart';

@immutable
abstract class ChangePasswordState {}

class InitialChangePasswordState extends ChangePasswordState {}

class ChangePasswordStateLoading extends ChangePasswordState{

}

class ChangePasswordStateSuccess extends ChangePasswordState{

}
class ChangePasswordStateFail extends ChangePasswordState{
  final dynamic error;

  ChangePasswordStateFail(this.error);

}