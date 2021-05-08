import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:estate_app/src/model/project.dart';
import 'package:estate_app/src/repositories/repositories.dart';
import 'package:meta/meta.dart';

part 'update_project_event.dart';

part 'update_project_state.dart';

class UpdateProjectBloc extends Bloc<UpdateProjectEvent, UpdateProjectState> {
  Repositories repositories = Repositories();
  UpdateProjectBloc() : super(InitialUpdateProjectState());

  @override
  Stream<UpdateProjectState> mapEventToState(UpdateProjectEvent event) async* {
    if (event is UpdateProjectEventSubmit) {
      yield UpdateProjectStateLoading();
      try{
        await repositories.projectRepositories.updateProject(event.idProject, event.project);
        yield UpdateProjectStateSuccess();
      }catch(e){
        yield UpdateProjectStateFail(e.toString());
      }
    }
  }
}
