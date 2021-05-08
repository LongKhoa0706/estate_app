import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:estate_app/src/model/users.dart';
import 'package:estate_app/src/repositories/repositories.dart';
import 'package:meta/meta.dart';

part 'list_like_project_event.dart';

part 'list_like_project_state.dart';

class ListLikeProjectBloc extends Bloc<ListLikeProjectEvent, ListLikeProjectState> {
  Repositories repositories = Repositories();
  ListLikeProjectBloc() : super(InitialListLikeProjectState());


  @override
  Stream<ListLikeProjectState> mapEventToState(
      ListLikeProjectEvent event) async* {
    if (event is ListLikeProjectEventFetchData) {
      yield ListLikeProjectStateLoading();
      try{
       List<Users> listUser =  await repositories.projectRepositories.listLikeProject(event.idProject);
        yield ListLikeProjectStateSuccess(listUser);
      }catch(e){
        yield ListLikeProjectStateFail(e.toString());
      }
    }  
  }
}
