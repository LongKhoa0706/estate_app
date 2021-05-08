import 'package:dio/dio.dart';
import 'package:estate_app/src/model/new.dart';
import 'package:estate_app/src/networkings/apiClient.dart';
import 'package:estate_app/src/utils/endpoint.dart';

class NewProvider{

  Future<Response> addNew(New news ) async{
    try {
      final res = await ApiClient.instance.dio.post(Endpoint.addNew, data: news.toJson());
      return res;
    } on DioError catch (e) {
      throw e.response.data['message'];
    }
  }
  Future<Response> getListNew() async{
    try {
      final res = await ApiClient.instance.dio.get(Endpoint.getNew);
      return res;
    } on DioError catch (e) {
      throw e.response.data['message'];
    }
  }
}