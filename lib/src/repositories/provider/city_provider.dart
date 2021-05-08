import 'package:dio/dio.dart';
import 'package:estate_app/src/networkings/apiClient.dart';

class CityProvider{
  Future<Response> getAllCity() async {
    try{
      final response = await ApiClient.instance.dio.get('http://nhadatchinhchu.billionaire-land.net/api/get-provinces');
      return response;
    }on DioError catch(e){
      print(e.response.data);
    }
  }

  Future<Response> getDistrictByCity(int idCity) async {
    try{
      final response = await ApiClient.instance.dio.get('http://nhadatchinhchu.billionaire-land.net/api/get-districts/$idCity');
      return response;
    }on DioError catch(e){
      print(e.response.data);
    }
  }
  Future<Response> getWardByDistrict(int idDistrict) async {
    try{
      final response = await ApiClient.instance.dio.get('http://nhadatchinhchu.billionaire-land.net/api/get-wards/$idDistrict');
      return response;
    }on DioError catch (e){
      
    }
  }
}