import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:estate_app/src/model/comment.dart';
import 'package:estate_app/src/repositories/repositories.dart';
import 'package:meta/meta.dart';

part 'list_reply_comment_event.dart';

part 'list_reply_comment_state.dart';

class ListReplyCommentBloc extends Bloc<ListReplyCommentEvent, ListReplyCommentState> {
  Repositories repositories = Repositories();
  ListReplyCommentBloc() : super(InitialListReplyCommentState());

  @override
  Stream<ListReplyCommentState> mapEventToState(
      ListReplyCommentEvent event) async* {
    if (event is ListReplyCommentEventFetchData) {
      yield ListReplyCommentStateLoading();
      try{
        List<Comment> listReplyComment = await repositories.projectRepositories.listReplyComment(event.idProject, event.idComment);
        yield ListReplyCommentStateSuccess(listReplyComment);
      }catch(e) {
        yield ListReplyCommentStateFail(e.toString());
      }
    }
  }
}
