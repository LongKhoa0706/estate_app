part of 'change_password_bloc.dart';

@immutable
abstract class ChangePasswordEvent {}

class ChangePasswordEventSubmit extends ChangePasswordEvent{
  final String email;
  final String password;
  final String rePassword;

  ChangePasswordEventSubmit(this.email, this.password, this.rePassword);
}