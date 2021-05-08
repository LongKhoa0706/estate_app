part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class InitialAuthState extends AuthState {}

class AuthStateLoading extends AuthState{}

class AuthStateFaire extends AuthState{
  final dynamic error;

  AuthStateFaire(this.error);

  String toString() => '$runtimeType ${error.toString()}';
}
class AuthStateSuccess extends AuthState{

}