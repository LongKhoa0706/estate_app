part of 'update_user_bloc.dart';

@immutable
abstract class UpdateUserEvent {}

class UpdateUserInforEvent extends UpdateUserEvent {
  final String userName,  date, personal,firstName,lastName;

  UpdateUserInforEvent(this.userName, this.date, this.personal, this.firstName, this.lastName);



}
