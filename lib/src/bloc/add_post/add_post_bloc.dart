import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:estate_app/src/repositories/repositories.dart';
import 'package:meta/meta.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

part 'add_post_event.dart';

part 'add_post_state.dart';

class AddPostBloc extends Bloc<AddPostEvent, AddPostState> {
  Repositories repositories = Repositories();
  AddPostBloc() : super(InitialAddPostState());

  @override
  Stream<AddPostState> mapEventToState(AddPostEvent event) async* {
    if (event is AddPostEventSubmit) {
      yield AddPostStateLoading();
      try{
        await repositories.postRepositories.addPost(event.content, event.listImageProject);
        yield AddPostStateSuccess();
      }catch(e){
        yield AddPostStateFail(e.toString());
      }
    }
  }
}
