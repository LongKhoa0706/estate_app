import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:estate_app/src/model/project.dart';
import 'package:estate_app/src/repositories/repositories.dart';
import 'package:meta/meta.dart';

part 'get_my_project_event.dart';

part 'get_my_project_state.dart';

class GetMyProjectBloc extends Bloc<GetMyProjectEvent, GetMyProjectState> {
  Repositories repositories = Repositories();
  GetMyProjectBloc() : super(InitialGetMyProjectState());


  @override
  Stream<GetMyProjectState> mapEventToState(GetMyProjectEvent event) async* {
    if (event is GetMyProjectEventFetching) {
      yield GetMyProjectStateLoading();
      try{
        List<Project> listMyProject = await repositories.projectRepositories.getProjectUser(event.idUser);
        yield GetMyProjectStateSuccess(listMyProject);
      }catch(e){
        print(e.toString());
        yield GetMyProjectStateFail(e.toString());
      }
    }
  }
}
