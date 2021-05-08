import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:estate_app/src/model/users.dart';
import 'package:estate_app/src/repositories/repositories.dart';
import 'package:meta/meta.dart';

part 'list_like_post_event.dart';

part 'list_like_post_state.dart';

class ListLikePostBloc extends Bloc<ListLikePostEvent, ListLikePostState> {
  Repositories repositories = Repositories();
  ListLikePostBloc() : super(InitialListLikePostState());

  @override
  Stream<ListLikePostState> mapEventToState(ListLikePostEvent event) async* {
    if (event is ListLikePostEventFetchData) {
      yield ListLikePostStateLoading();
      try{
        List<Users> listLikeUser = await repositories.postRepositories.listLikePost(event.idPost);
        yield ListLikePostStateSuccess(listLikeUser);
      }catch(e){
        yield ListLikePostStateFail(e.toString());
      }
    }
  }
}
