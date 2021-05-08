import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:estate_app/src/model/project.dart';
import 'package:estate_app/src/repositories/repositories.dart';
import 'package:meta/meta.dart';

part 'my_favorite_event.dart';

part 'my_favorite_state.dart';

class MyFavoriteBloc extends Bloc<MyFavoriteEvent, MyFavoriteState> {
  MyFavoriteBloc() : super(InitialMyFavoriteState());
  Repositories repositories = Repositories();


  @override
  Stream<MyFavoriteState> mapEventToState(MyFavoriteEvent event) async* {
    if (event is MyFavoriteEventFetchData) {
      yield MyFavoriteStateLoading();
      try{
        List<Project> listProjectMyLike = await repositories.projectRepositories.listProjectMyLike();
        yield MyFavoriteStateSuccess(listProjectMyLike);
      }catch(e){
        yield  MyFavoriteStateFail(e.toString());
      }
    }
  }
}
