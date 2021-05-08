import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:estate_app/src/repositories/repositories.dart';
import 'package:meta/meta.dart';

part 'change_password_event.dart';

part 'change_password_state.dart';

class ChangePasswordBloc extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  ChangePasswordBloc() : super(InitialChangePasswordState());
  Repositories repositories = Repositories();

  @override
  Stream<ChangePasswordState> mapEventToState(
      ChangePasswordEvent event) async* {
    if (event is ChangePasswordEventSubmit) {
      yield ChangePasswordStateLoading();
      try{
        await repositories.userRepositories.changePassword(event.email, event.password, event.rePassword);
        yield ChangePasswordStateSuccess();
      }catch(e){
        yield ChangePasswordStateFail(e.toString());
      }
    }
  }
}
