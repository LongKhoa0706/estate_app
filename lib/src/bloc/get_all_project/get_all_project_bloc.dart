import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:estate_app/src/model/project.dart';
import 'package:estate_app/src/repositories/repositories.dart';
import 'package:meta/meta.dart';

part 'get_all_project_event.dart';

part 'get_all_project_state.dart';

class GetAllProjectBloc extends Bloc<GetAllProjectEvent, GetAllProjectState> {
  Repositories repositories = Repositories();
  GetAllProjectBloc() : super(InitialGetAllProjectState());

  @override
  Stream<GetAllProjectState> mapEventToState(GetAllProjectEvent event) async* {
    if (event is GetAllProjectEventFetching) {
      yield GetAllProjectStateLoading();
      try{
       List<Project> listProject =  await repositories.projectRepositories.getAllProject();
        yield GetAllProjectStateSuccess(listProject);
      }catch(e){
        yield GetAllProjectStateFail(e.toString());
      }
    }
  }
}
