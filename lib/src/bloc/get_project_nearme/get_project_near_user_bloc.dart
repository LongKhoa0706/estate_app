 import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:estate_app/src/model/project.dart';
import 'package:estate_app/src/repositories/repositories.dart';
import 'package:meta/meta.dart';

part 'get_project_near_user_event.dart';
part 'get_project_near_user_state.dart';

class GetProjectNearUserBloc extends Bloc<GetProjectNearUserEvent, GetProjectNearUserState> {
  GetProjectNearUserBloc() : super(GetProjectNearUserInitial());
  Repositories repositories = Repositories();

  @override
  Stream<GetProjectNearUserState> mapEventToState(
    GetProjectNearUserEvent event,
  ) async* {
    if (event is GetProjectNearUserEventFetchDataNear) {
      yield GetProjectNearUserStateLoading();
      try{
        List<Project> listProject = await repositories.projectRepositories.getProjectNearUser(event.lat, event.lng, event.distance);
        yield GetProjectNearUserStateSuccess(listProject);
      }catch(e){
        yield GetProjectNearUserFail(e.toString());
      }
    }
  }
}
