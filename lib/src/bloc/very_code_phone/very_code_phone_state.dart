part of 'very_code_phone_bloc.dart';

@immutable
abstract class VeryCodePhoneState {}

class InitialVeryCodePhoneState extends VeryCodePhoneState {}

class VeryCodePhoneStateLoading extends VeryCodePhoneState{}

class VeryCodePhoneStateSuccess extends VeryCodePhoneState{}

class VeryCodePhoneStateFail extends VeryCodePhoneState{}