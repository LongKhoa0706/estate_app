
import 'package:dio/dio.dart';
import 'package:estate_app/src/networkings/apiClient.dart';
import 'package:estate_app/src/utils/endpoint.dart';

class HomeProvider {
  Future<Response> getNews() async {
    try {
      final res = await ApiClient.instance.dio.get(Endpoint.getNews);
      return res;
    } on DioError catch (e) {
      print(e.error);
    }
  }
  Future<Response> getProject() async {
    try {
      final res = await ApiClient.instance.dio.post(
        Endpoint.getProject,
      );
      return res;
    } catch (e) {
      print(e);
    }
  }
  Future<Response> getBannerProject() async{
    try{
      final res = await ApiClient.instance.dio.get(
        Endpoint.getBanner,
      );
      return res;
    }on DioError catch(e){
      print(e.response.data);
    }
  }
}
