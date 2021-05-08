part of 'very_code_phone_bloc.dart';

@immutable
abstract class VeryCodePhoneEvent {}

class VeryCodePhoneEventSubmit extends VeryCodePhoneEvent{
  final String code;

  VeryCodePhoneEventSubmit(this.code);

}