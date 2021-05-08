import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:estate_app/src/repositories/repositories.dart';
import 'package:meta/meta.dart';

part 'comment_project_event.dart';

part 'comment_project_state.dart';

class CommentProjectBloc extends Bloc<CommentProjectEvent, CommentProjectState> {

  CommentProjectBloc() : super(InitialCommentProjectState());
  Repositories repositories = Repositories();

  @override
  Stream<CommentProjectState> mapEventToState(
      CommentProjectEvent event) async* {
      if (event is CommentProjectEventSubmit) {
        yield CommentProjectStateLoading();
        try{
          await repositories.projectRepositories.createComment(event.idProject, event.commentContent,event.idComment);
          yield CommentProjectStateSuccess();
        }catch(e){
          yield CommentProjectStateFail(e.toString());
        }
      }
  }
}
