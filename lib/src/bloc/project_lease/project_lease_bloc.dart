import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:estate_app/src/model/project.dart';
import 'package:estate_app/src/repositories/repositories.dart';
import 'package:estate_app/src/utils/string.dart';
import 'package:meta/meta.dart';

part 'project_lease_event.dart';

part 'project_lease_state.dart';

class ProjectLeaseBloc extends Bloc<ProjectLeaseEvent, ProjectLeaseState> {
  ProjectLeaseBloc() : super(InitialProjectLeaseState());
  Repositories repositories = Repositories();

  @override
  Stream<ProjectLeaseState> mapEventToState(ProjectLeaseEvent event) async* {
    if (event is ProjectLeaseEventFetchData) {
      yield ProjectLeaseStateLoading();
      try{
        List<Project> listProject = await repositories.projectRepositories.getAllProjectLease(event.type);
        yield ProjectLeaseStateSuccess(listProject);
      }catch(e){
        yield ProjectLeaseStateFail(e.toString());

      }
    }
  }
}
