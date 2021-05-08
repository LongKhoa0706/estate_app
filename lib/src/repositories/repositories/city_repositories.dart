import 'package:estate_app/src/model/city.dart';
import 'package:estate_app/src/repositories/provider/city_provider.dart';

class CityRepositories {
  CityProvider cityProvider = CityProvider();
  List<Address> listCity = List();

  Future<List<Address>> getAllCity() async{
    final cityResponse = await cityProvider.getAllCity();
    List ciTyy = cityResponse.data['data'];
    listCity = ciTyy.map((e) => Address.fromJson(e)).toList();
    return listCity;
  }

  Future<List<Address>> getDistrictByCity(int idCity) async{
    List<Address> listDistrict = List();
    final cityResponse = await cityProvider.getDistrictByCity(idCity);
    List listDistrictt = cityResponse.data['data'];
    listDistrict = listDistrictt.map((e) => Address.fromJson(e)).toList();
    return listDistrict;
  }
  Future getWardByDistrict(int idDistrict) async {
     List<Address> listWard = List();
    final cityResponse = await cityProvider.getWardByDistrict(idDistrict);
    List listWardd = cityResponse.data['data'];
    listWard = listWardd.map((e) => Address.fromJson(e)).toList();
    return listWard;
  }
}