import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:estate_app/src/repositories/repositories.dart';
import 'package:meta/meta.dart';

part 'update_password_event.dart';

part 'update_password_state.dart';

class UpdatePasswordBloc extends Bloc<UpdatePasswordEvent, UpdatePasswordState> {
final  Repositories repositories = Repositories();

  UpdatePasswordBloc() : super(InitialUpdatePasswordState());


  @override
  Stream<UpdatePasswordState> mapEventToState(
      UpdatePasswordEvent event) async* {
    try{
      if (event is UpdatePasswordEventSubmit) {
        yield UpdatePasswordStateLoading();
        try{
         var a =  await repositories.userRepositories.updatePasswordUser(oldPassword: event.oldPassword, newPassword: event.newPassword);
          yield UpdatePasswordStateSuccess(a.data['message']);
        }catch(e){
          yield UpdatePasswordStateFail(e.toString());
        }
      }
    }catch(e){
      print(e.toString());
    }

  }
}
