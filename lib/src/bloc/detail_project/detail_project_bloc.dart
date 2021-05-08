import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:estate_app/src/model/project.dart';
import 'package:estate_app/src/repositories/repositories.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geocoder/model.dart';
import 'package:meta/meta.dart';

part 'detail_project_event.dart';

part 'detail_project_state.dart';

class DetailProjectBloc extends Bloc<DetailProjectEvent, DetailProjectState> {
  Repositories repositories = Repositories();
  DetailProjectBloc() : super(InitialDetailProjectState());

  @override
  Stream<DetailProjectState> mapEventToState(DetailProjectEvent event) async* {
    if (event is DetailProjectEventFetching) {
      yield DetailProjectStateLoading();
      try{
        Project project = await repositories.projectRepositories.detailProject(event.idProject);
        // var b = await convertAddressToLatLn(project.newsStreet);
        yield DetailProjectStateSuccess(project,null);
      }catch(e){
        yield DetailProjectStateFail(e.toString());
      }
    }
  }
  // Future<Address>convertAddressToLatLn(String address) async{
  //   var addresses = await Geocoder.local.findAddressesFromQuery(address);
  //   var first = addresses.first;
  //   return first;
  // }

}
