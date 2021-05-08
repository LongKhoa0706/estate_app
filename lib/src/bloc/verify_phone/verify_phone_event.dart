part of 'verify_phone_bloc.dart';

@immutable
abstract class VerifyPhoneEvent {}

class VerifyPhoneEventSubmit extends VerifyPhoneEvent {
  final String phone;
  final String email;


  VerifyPhoneEventSubmit(this.phone,this.email);

}
