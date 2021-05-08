
import 'package:dio/dio.dart';
import 'package:estate_app/src/model/users.dart';
import 'package:estate_app/src/utils/endpoint.dart';
import 'package:estate_app/src/networkings/apiClient.dart';

class AuthProvider {
  Future<Response> sendCodeToEmail(String email) async {
    try {
      final res = await ApiClient.instance.dio
          .post(Endpoint.sendCodeToEmail, data: {'email': email});
      return res;
    } on DioError catch (e) {
      print(e.message);
      print(e.response.data);
      handleDioError(e);
    }
  }

  Future<Response> checkPhone(String phone,String email) async {
    try {
      final res = await ApiClient.instance.dio
          .post(Endpoint.checkPhone, data: {'phone': phone,'email':email});
      return res;
    } on DioError catch (e) {
      throw e.response.data['message'];
    }
  }

  Future<Response> verifyCodeEmail(String email, String code) async {
    try {
      final res = await ApiClient.instance.dio.post(Endpoint.verifyCodeEmail, data: {
        'email': email,
        'code': code,
      });
      return res;
    } on DioError catch (e) {
      handleDioError(e);
    }
  }

  Future<Response> registerUser(Users user) async {
    try {
      FormData formData = FormData.fromMap({
        "passwords":user.passwords,
        "username":user.username,
        "job_id":user.job.id,
        "lastname":user.lastname,
        "firstname":user.firstname,
        "email":user.email,
        "phone":user.phone,
      });
      final res = await ApiClient.instance.dio.post(
        Endpoint.register,
        data: formData,
      );
      return res;
    } on DioError catch (e) {
      print(e.response.data);
      handleDioError(e);
    }
  }

  Future<Response> loginUser(String username, String password) async {
    try {
      final response = await ApiClient.instance.dio.post(Endpoint.login, data: {
        'passwords': password,
        'username': username,
        'phone':username,
        'email':username,
      });
      // print("auth "+ response.);
      return response;
    } on DioError catch (e) {
      // print("catch auth "+ e.response.statusCode.toString());
      handleDioError(e);
    }
  }
  Future<Response> logoutUser() async {
    try{
      final response = await ApiClient.instance.dio.get(Endpoint.logoutUser);
      return response;
    }on DioError catch(e){
      print(e.toString());
    }
  }

  String handleDioError(DioError e) {
    switch (e.response.statusCode) {
      case 403:
        throw(e.response.data['message']);// thow day loi
      case 205:
        throw(e.response.data['message']);
      case 400:
        throw(e.response.data['message']);
      case 500:
        throw(e.response.data['message']);
      default:
        print(e.response.statusCode);
    }
  }
}
