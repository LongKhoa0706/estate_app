import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:estate_app/src/model/comment.dart';
import 'package:estate_app/src/repositories/repositories.dart';
import 'package:meta/meta.dart';

part 'list_comment_post_event.dart';

part 'list_comment_post_state.dart';

class ListCommentPostBloc extends Bloc<ListCommentPostEvent, ListCommentPostState> {
  ListCommentPostBloc() : super(InitialListCommentPostState());
  Repositories repositories = Repositories();

  @override
  Stream<ListCommentPostState> mapEventToState(ListCommentPostEvent event) async* {
    if (event is ListCommentPostEventFetchData) {
      yield ListCommentPostStateLoading();
      try{
        List<Comment> listCommentPost = await repositories.postRepositories.listCommentByProject(event.postId);
        yield ListCommentPostStateSuccess(listCommentPost);
      }catch(e){
        yield ListCommentPostStateFail(e);
      }
    }
  }
}
