part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {

}

class AuthEventRegisterSubmit extends AuthEvent {
  final Users user;

  AuthEventRegisterSubmit(this.user);
}

class AuthEvenForgotPassword extends AuthEvent{
  final String email;
  AuthEvenForgotPassword(this.email);
}

class AuthEvenVerifyCodeEmail extends AuthEvent {
  final String email;
  final String code;

  AuthEvenVerifyCodeEmail(this.email, this.code);
}

class AuthEventLogin extends AuthEvent {
  final String email;
  final String passwords;

  AuthEventLogin(this.email, this.passwords);
}

class AuthEventLogout extends AuthEvent{

}
