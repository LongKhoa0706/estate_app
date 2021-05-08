import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:estate_app/src/repositories/repositories.dart';
import 'package:meta/meta.dart';

part 'very_code_phone_event.dart';

part 'very_code_phone_state.dart';

class VeryCodePhoneBloc extends Bloc<VeryCodePhoneEvent, VeryCodePhoneState> {
  VeryCodePhoneBloc() : super(InitialVeryCodePhoneState());
  Repositories repositories = Repositories();

  @override
  Stream<VeryCodePhoneState> mapEventToState(VeryCodePhoneEvent event) async* {
    if (event is VeryCodePhoneEventSubmit) {
      yield VeryCodePhoneStateLoading();
      try{
        await repositories.authRepositories.verifyCode(event.code);
        yield VeryCodePhoneStateSuccess();
      }catch(e){
        yield VeryCodePhoneStateFail();
      }
    }
  }
}
