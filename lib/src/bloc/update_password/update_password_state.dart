part of 'update_password_bloc.dart';

@immutable
abstract class UpdatePasswordState {}

class InitialUpdatePasswordState extends UpdatePasswordState {}

class UpdatePasswordStateSuccess extends UpdatePasswordState{
  final dynamic message;

  UpdatePasswordStateSuccess(this.message);


}
class UpdatePasswordStateFail extends UpdatePasswordState{
  final dynamic error;

  UpdatePasswordStateFail(this.error);
  String toString() => '$runtimeType ${error.toString()}';

}

class UpdatePasswordStateLoading extends UpdatePasswordState{

}