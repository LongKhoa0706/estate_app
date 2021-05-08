import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:estate_app/src/model/new.dart';
import 'package:estate_app/src/repositories/repositories.dart';
import 'package:meta/meta.dart';

part 'add_new_event.dart';

part 'add_new_state.dart';

class AddNewBloc extends Bloc<AddNewEvent, AddNewState> {
  AddNewBloc() : super(InitialAddNewState());
  Repositories repositories = Repositories();

  @override
  Stream<AddNewState> mapEventToState(AddNewEvent event) async* {
    if (event is AddNewEventSubmit) {
      yield AddNewStateLoading();
      try{
        await repositories.newsRepositories.addNew(event.news);
        yield AddNewStateSuccess();
      }catch(e){
        yield AddNewStateFail(e.toString());
      }
    }
  }
}
