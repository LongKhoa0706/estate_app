import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:estate_app/src/model/city.dart';
import 'package:estate_app/src/repositories/repositories.dart';
import 'package:meta/meta.dart';

part 'city_event.dart';

part 'city_state.dart';

class CityBloc extends Bloc<CityEvent, CityState> {
  Repositories repositories = Repositories();

  CityBloc() : super(InitialCityState());

  @override
  Stream<CityState> mapEventToState(CityEvent event) async* {
    if (event is CityEventFetching) {
       try{
        List<Address> listCity =  await repositories.cityRepositories.getAllCity();
        print("CITY BLOC" + listCity.length.toString());
         yield CityStateSuccessCity(listCity);
       }catch(e){
         print(e);
       }
    }
    if (event is CityEventFetchDistrictByCity) {
      try{
        // List<District> listDistrict = await repositories.cityRepositories.getDistrictByCity(event.idCity);
        // print(listDistrict.length);

      }catch(e){
        print(e.toString());
      }
    }
  }
}
