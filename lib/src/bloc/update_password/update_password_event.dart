part of 'update_password_bloc.dart';

@immutable
abstract class UpdatePasswordEvent {}

class UpdatePasswordEventSubmit extends UpdatePasswordEvent {
  final String oldPassword;
  final String newPassword;

  UpdatePasswordEventSubmit(this.oldPassword, this.newPassword);

}