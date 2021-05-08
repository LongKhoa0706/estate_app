import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:estate_app/src/model/project.dart';
import 'package:estate_app/src/repositories/repositories.dart';
import 'package:meta/meta.dart';

part 'search_project_event.dart';

part 'search_project_state.dart';

class SearchProjectBloc extends Bloc<SearchProjectEvent, SearchProjectState> {
  SearchProjectBloc() : super(InitialSearchProjectState());
  Repositories repositories = Repositories();
  @override
  Stream<SearchProjectState> mapEventToState(SearchProjectEvent event) async* {
    if (event is SearchProjectEventSubmit) {
      yield SearchProjectStateLoading();
      try{
       List<Project> listSearch =  await repositories.projectRepositories.searchProject(event.typeSearch2,event.keyWord,event.typeOptionSearch,event.keyword2,);
        yield SearchProjectStateSuccess(listSearch);
      }catch(e){
        yield SearchProjectStateFail(e.toString());
      }
    }
  }
}
