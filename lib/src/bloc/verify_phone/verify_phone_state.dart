part of 'verify_phone_bloc.dart';

@immutable
abstract class VerifyPhoneState {}

class InitialVerifyPhoneState extends VerifyPhoneState {}

class VerifyPhoneStateLoading extends VerifyPhoneState{}

class VerifyPhoneStateSuccess extends VerifyPhoneState{
}

class VerifyPhoneStateFail extends VerifyPhoneState{
  final dynamic error;

  VerifyPhoneStateFail(this.error);
}
