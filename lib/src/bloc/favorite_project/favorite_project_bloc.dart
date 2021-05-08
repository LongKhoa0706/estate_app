import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:estate_app/src/model/favoriteproject.dart';
import 'package:estate_app/src/repositories/repositories.dart';
import 'package:meta/meta.dart';

part 'favorite_project_event.dart';

part 'favorite_project_state.dart';

class FavoriteProjectBloc
    extends Bloc<FavoriteProjectEvent, FavoriteProjectState> {
  Repositories repositories = Repositories();
  FavoriteProjectBloc() : super(InitialFavoriteProjectState());

  @override
  Stream<FavoriteProjectState> mapEventToState(
      FavoriteProjectEvent event) async* {
    if (event is FavoriteProjectEventFetchData) {
      yield FavoriteProjectStateLoading();
      try{
        List<FavoriteProject>  listFavoriteProject = await repositories.projectRepositories.getFavoriteProject();
        yield FavoriteProjectStateSuccess(listFavoriteProject);
      }catch(e){
        yield FavoriteProjectStateFail(e.toString());
      }
    }
  }
}
