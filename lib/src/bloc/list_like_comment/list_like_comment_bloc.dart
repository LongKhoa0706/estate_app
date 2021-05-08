import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:estate_app/src/model/comment.dart';
import 'package:estate_app/src/model/users.dart';
import 'package:estate_app/src/repositories/repositories.dart';
import 'package:meta/meta.dart';

part 'list_like_comment_event.dart';

part 'list_like_comment_state.dart';

class ListLikeCommentBloc extends Bloc<ListLikeCommentEvent, ListLikeCommentState> {
  Repositories repositories = Repositories();
  ListLikeCommentBloc() : super(InitialListLikeCommentState());

  @override
  Stream<ListLikeCommentState> mapEventToState(ListLikeCommentEvent event) async* {
    if (event is ListLikeCommentEventFetching) {
      try{
        yield ListLikeCommentStateLoading();
        List<Users> listLikeComment =  await repositories.projectRepositories.listLikeComment(event.idComment);
        yield ListLikeCommentStateSuccess(listLikeComment);
      }catch(e){
        yield ListLikeCommentStateFail(e.toString());
      }
    }
  }
}
