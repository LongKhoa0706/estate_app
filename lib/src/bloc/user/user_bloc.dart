import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:estate_app/src/model/users.dart';
import 'package:estate_app/src/repositories/repositories.dart';
import 'package:meta/meta.dart';

part 'user_event.dart';

part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(InitialUserState());
  Repositories repositories = Repositories();
  Users user;
  int iduser;

  @override
  UserState get initialState => InitialUserState();

  @override
  Stream<UserState> mapEventToState(UserEvent event) async* {
    if (event is UserEventFetchData) {
        yield UserStateLoading();
       user = await repositories.userRepositories.getUser();
       iduser = await repositories.userRepositories.idUser;
        yield UserStateSuccess(user,iduser);
    }

    if (event is UserEventFetchDetailData) {
      yield UserStateLoading();
       try{
         Users user1 =  await repositories.userRepositories.getDetaillUser(event.idUser);
         yield UserStateSuccess(user1,event.idUser);
       }catch(e){
         print(e.toString());
       }
    }
  }
}
