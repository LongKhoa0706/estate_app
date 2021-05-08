import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:estate_app/src/model/project.dart';
import 'package:estate_app/src/repositories/repositories.dart';
import 'package:meta/meta.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

part 'add_project_event.dart';

part 'add_project_state.dart';

class AddProjectBloc extends Bloc<AddProjectEvent, AddProjectState> {
  AddProjectBloc() : super(InitialAddProjectState());

  Repositories repositories = Repositories();

  @override
  Stream<AddProjectState> mapEventToState(AddProjectEvent event) async* {
    // TODO: Add your event logic
    if (event is AddProjectEventSubmit) {
      yield AddProjectStateLoading();
      try{
        await repositories.projectRepositories.createProjectt(event.project,event.urlImageLogo,event.listImageProject);
        yield AddProjectStateSuccess();
      }catch(e){
        yield AddProjectStateFail(e.toString());
      }
    }
  }
}
