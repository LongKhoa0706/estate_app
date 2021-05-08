import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:estate_app/src/model/project.dart';
import 'package:estate_app/src/repositories/repositories.dart';
import 'package:meta/meta.dart';

part 'search_project_advance_event.dart';

part 'search_project_advance_state.dart';

class SearchProjectAdvanceBloc extends Bloc<SearchProjectAdvanceEvent, SearchProjectAdvanceState> {
  SearchProjectAdvanceBloc() : super(InitialSearchProjectAdvanceState());
  Repositories repositories = Repositories();

  @override
  Stream<SearchProjectAdvanceState> mapEventToState(
      SearchProjectAdvanceEvent event) async* {
    if (event is SearchProjectAdvanceEventSubtmit) {
      yield SearchProjectAdvanceStateLoading();
      try{
        List<Project> listResultScreen = await repositories.projectRepositories.serachProjectAdvance(event.categories, event.title, event.minPrice,  event.maxPrice,  event.provincial);
        yield SearchProjectAdvanceStateSuccess(listResultScreen);
      }catch(e){
        yield SearchProjectAdvanceStateFail(e.toString());
      }
    }  
  }
}
