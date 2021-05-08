import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:estate_app/src/repositories/repositories.dart';
import 'package:meta/meta.dart';

part 'delete_project_event.dart';

part 'delete_project_state.dart';

class DeleteProjectBloc extends Bloc<DeleteProjectEvent, DeleteProjectState> {
  DeleteProjectBloc() : super(InitialDeleteProjectState());
  Repositories repositories = Repositories();

  @override
  Stream<DeleteProjectState> mapEventToState(DeleteProjectEvent event) async* {
    if (event is DeleteProjectEventSubmit) {
      yield DeleteProjectStateLoading();
      try{
        await repositories.projectRepositories.deleteProject(event.idProject);
        yield DeleteProjectStateSuccess();
      }catch(e){
        print(e.toString());
      }
    }
  }
}
