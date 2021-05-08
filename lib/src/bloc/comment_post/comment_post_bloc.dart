import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:estate_app/src/repositories/repositories.dart';
import 'package:meta/meta.dart';

part 'comment_post_event.dart';

part 'comment_post_state.dart';

class CommentPostBloc extends Bloc<CommentPostEvent, CommentPostState> {
  Repositories repositories = Repositories();
  CommentPostBloc() : super(InitialCommentPostState());
  @override
  Stream<CommentPostState> mapEventToState(CommentPostEvent event) async* {
    if (event is CommentPostEventSubmit) {
      yield CommentPostStateLoading();
      try{
        await repositories.postRepositories.createComment(event.idProject, event.commentContent,event.idComment);
        yield CommentPostStateSuccess();
      }catch(e){
        yield CommentPostStateFail(e);
      }
    }
  }
}
