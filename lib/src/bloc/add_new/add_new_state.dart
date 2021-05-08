part of 'add_new_bloc.dart';

@immutable
abstract class AddNewState {}

class InitialAddNewState extends AddNewState {}

class AddNewStateLoading extends AddNewState{

}
class AddNewStateSuccess extends AddNewState {

}
class AddNewStateFail extends AddNewState {
  final dynamic error;

  AddNewStateFail(this.error);

}