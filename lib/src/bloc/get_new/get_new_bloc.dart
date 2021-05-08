import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:estate_app/src/model/new.dart';
import 'package:estate_app/src/repositories/repositories.dart';
import 'package:meta/meta.dart';

part 'get_new_event.dart';

part 'get_new_state.dart';

class GetNewBloc extends Bloc<GetNewEvent, GetNewState> {
  GetNewBloc() : super(InitialGetNewState());
  Repositories repositories =  Repositories();



  @override
  Stream<GetNewState> mapEventToState(GetNewEvent event) async* {
    if (event is GetNewEventFetchData) {
      yield GetNewStateLoading();
      try{
        List<New> listNew = await repositories.newsRepositories.getNew();
        yield GetNewStateSuccess(listNew);
      }catch(e){
        yield GetNewStateFail(e.toString());
      }
    }
  }
}
