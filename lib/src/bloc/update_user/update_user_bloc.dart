import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:estate_app/src/model/users.dart';
import 'package:estate_app/src/repositories/repositories.dart';
import 'package:meta/meta.dart';

part 'update_user_event.dart';

part 'update_user_state.dart';

class UpdateUserBloc extends Bloc<UpdateUserEvent, UpdateUserState> {
  Repositories repositories = Repositories();

  UpdateUserBloc() : super(InitialUpdateUserState());


  @override
  Stream<UpdateUserState> mapEventToState(UpdateUserEvent event) async* {
    if (event is UpdateUserInforEvent) {
      yield UpdateUserStateLoading();
      try {
        await repositories.userRepositories.updateUser(event.userName,event.date,event.personal,event.firstName,event.lastName);
        yield UpdateUserStateSuccess();
      } catch (e) {
        yield UpdateUserStateFail(e.toString());
      }
    }
  }
}
