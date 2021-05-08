import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:estate_app/src/model/post.dart';
import 'package:estate_app/src/repositories/repositories.dart';
import 'package:meta/meta.dart';

part 'get_my_post_event.dart';

part 'get_my_post_state.dart';

class GetMyPostBloc extends Bloc<GetMyPostEvent, GetMyPostState> {
  GetMyPostBloc() : super(InitialGetMyPostState());
  Repositories repositories = Repositories();
  @override
  Stream<GetMyPostState> mapEventToState(GetMyPostEvent event) async* {
    if (event is GetMyPostEventFetch) {
      yield GetMyPostStateLoading();
      try{
        List<Post> listMyPost =  await repositories.postRepositories.getProjectUser(event.idUser);
        yield GetMyPostStateSuccess(listMyPost);
      }catch(e){

      }
    }
  }
}
