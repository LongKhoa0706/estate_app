import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:estate_app/src/repositories/repositories.dart';
import 'package:estate_app/src/service/share_pref.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'verify_phone_event.dart';

part 'verify_phone_state.dart';

class VerifyPhoneBloc extends Bloc<VerifyPhoneEvent, VerifyPhoneState> {
  VerifyPhoneBloc() : super(InitialVerifyPhoneState());
  Repositories repositories = Repositories();


  @override
  Stream<VerifyPhoneState> mapEventToState(VerifyPhoneEvent event) async* {
    if (event is VerifyPhoneEventSubmit) {
      yield VerifyPhoneStateLoading();
      try{
        await repositories.authRepositories.verfiyPhone(event.phone,event.email);
        // await SharedPrefService.setString(key: "phone",value: event.phone);
        yield VerifyPhoneStateSuccess();
      }catch(e){
        yield VerifyPhoneStateFail(e.toString());
      }
    }
  }
}
