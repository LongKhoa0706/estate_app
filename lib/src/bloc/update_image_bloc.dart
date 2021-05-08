import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:estate_app/src/repositories/repositories.dart';
import 'package:meta/meta.dart';

part 'update_image_event.dart';
part 'update_image_state.dart';

class UpdateImageBloc extends Bloc<UpdateImageEvent, UpdateImageState> {
  UpdateImageBloc() : super(UpdateImageInitial());
  Repositories repositories = Repositories();

  @override
  Stream<UpdateImageState> mapEventToState(UpdateImageEvent event)async* {
    if (event is UploadImageEvent) {
      yield UpdateImageLoading();
      try{
       String urlImage =  await repositories.userRepositories.updateImageUser(event.image);
        yield UpdateImageStateSuccess(urlImage);
      }catch(e){
        yield UpdateImageStateFail(e.toString());
      }
    }
  }
}
