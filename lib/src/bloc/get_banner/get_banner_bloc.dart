import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:estate_app/src/repositories/repositories.dart';
import 'package:meta/meta.dart';

part 'get_banner_event.dart';

part 'get_banner_state.dart';

class GetBannerBloc extends Bloc<GetBannerEvent, GetBannerState> {
  GetBannerBloc() : super(InitialGetBannerState());
  Repositories repositories = Repositories();


  @override
  Stream<GetBannerState> mapEventToState(GetBannerEvent event) async* {
    if (event is GetBannerEventFetchData) {
      yield GetBannerStateLoading();
      try{
        List<String> listImageBanner = await repositories.homeRepositories.getBanner();
        yield GetBannerStateSuccess(listImageBanner);
      }catch(e){
        yield GetBannerStateFail(e.toString());
      }
    }
  }
}
