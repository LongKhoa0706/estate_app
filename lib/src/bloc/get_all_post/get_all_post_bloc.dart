import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:estate_app/src/model/post.dart';
import 'package:estate_app/src/repositories/repositories.dart';
import 'package:meta/meta.dart';

part 'get_all_post_event.dart';

part 'get_all_post_state.dart';

class GetAllPostBloc extends Bloc<GetAllPostEvent, GetAllPostState> {
  Repositories repositories = Repositories();
  GetAllPostBloc() : super(InitialGetAllPostState());

  @override
  Stream<GetAllPostState> mapEventToState(GetAllPostEvent event) async* {
    if (event is GetAllPostEventFetchData) {
      yield GetAllPostStateLoading();
      try{
        List<Post> listPost = await repositories.postRepositories.getAllPost();
        yield GetAllPostStateSuccess(listPost);
      }catch(e){
        yield GetAllPostStateFail(e.toString());
      }
    }
  }
}
