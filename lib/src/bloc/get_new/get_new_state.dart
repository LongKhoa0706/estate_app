part of 'get_new_bloc.dart';

@immutable
abstract class GetNewState {}

class InitialGetNewState extends GetNewState {}

class GetNewStateLoading extends GetNewState{}

class GetNewStateSuccess extends GetNewState{
  final List<New> listNew;

  GetNewStateSuccess(this.listNew);

}

class GetNewStateFail extends GetNewState{
  final dynamic error;

  GetNewStateFail(this.error);

}