import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'like_project_event.dart';

part 'like_project_state.dart';

class LikeProjectBloc extends Bloc<LikeProjectEvent, LikeProjectState> {
  @override
  LikeProjectState get initialState => InitialLikeProjectState();

  @override
  Stream<LikeProjectState> mapEventToState(LikeProjectEvent event) async* {
    // TODO: Add your event logic
  }
}
