import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:estate_app/src/model/comment.dart';
import 'package:estate_app/src/repositories/repositories.dart';
import 'package:meta/meta.dart';

part 'list_comment_project_event.dart';

part 'list_comment_project_state.dart';
class ListCommentProjectBloc
    extends Bloc<ListCommentProjectEvent, ListCommentProjectState> {

  ListCommentProjectBloc() : super(InitialListCommentProjectState());
  Repositories repositories = Repositories();

  @override
  Stream<ListCommentProjectState> mapEventToState(
      ListCommentProjectEvent event) async* {
    if (event is ListCommentProjectEventFetch) {
      yield ListCommentProjectStateLoading();
      try{
        List<Comment> listComment  = await repositories.projectRepositories.listCommentByProject(event.idProject);
        yield ListCommentProjectStateSuccess(listComment);
      }catch (e){
        print(e.toString());
      }

    }
  }
}
