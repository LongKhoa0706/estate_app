import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:estate_app/src/model/users.dart';
import 'package:estate_app/src/networkings/apiClient.dart';
import 'package:estate_app/src/utils/endpoint.dart';
import 'package:estate_app/src/utils/string.dart';
import 'package:http_parser/http_parser.dart';

class UserProvider {
  Future<Response> getUser() async {
    try{
      final res = await ApiClient.instance.dio.get(Endpoint.getProfile);
      return res;
    } on DioError catch(e) {
      print(e.message);
    }
  }
  Future<Response> getDetailProfile(int idUser) async {
    try{
      final res = await ApiClient.instance.dio.get(Endpoint.getDetailProfile+'/$idUser');
      return res;
    } on DioError catch(e){
      print('userprovider '+ e.error);
    }
  }

  Future<Response> getAllJob() async {
    try{
      final res = await ApiClient.instance.dio.get(Endpoint.getJob);
      return res;
    } on DioError catch(e){
      print('userprovider '+ e.error);
    }
  }

Future<Response> updateUser(String userName,String date,String personal,String firstName,String lastName) async {
  try{
    print("TRY");
    final res = await ApiClient.instance.dio.post(Endpoint.updateUser, data: {
      'username':userName,
      'personal_info':personal,
      'birth_date':date,
      'firstname':firstName,
      'lastname':lastName
    });
    return res;
  }on DioError catch(e){
    print("CATCH");
    throw(e.response.data['message']);
  }

}

  Future<Response> updatePassword(String oldPassword,String newPassword) async {
   try {
     final response = await ApiClient.instance.dio.post(Endpoint.updatePassword,data: {
       'old_password':oldPassword,
       'new_password':newPassword,
     });
     print("user provider "+ response.statusCode.toString());
     return response;
   }on DioError  catch(e){
      // print("catch "+ e.response.data.toString());
     throw(e.response.data['message']);
     // print(e.toString());
     //  handleDioError(e);
   }
  }

  Future<Response> sendMessage(String message) async {
    try {
      final response = await ApiClient.instance.dio.post(Endpoint.sendMessageAdmin,data: {
        'message':message,
      });

      return response;
    }on DioError  catch(e){
      print("catch "+ e.response.data.toString());

    }
  }

  Future<Response> changePassword(String email,String password,String rePassword) async {
    try {
      final response = await ApiClient.instance.dio.post(Endpoint.changePassword,data: {
        'email':email,
        'password':password,
        'repassword':rePassword,
      });
      return response;
    }on DioError  catch(e){
      print("catch "+ e.response.data.toString());
       handleDioError(e);
    }
  }

  Future<Response> getMessage() async {
    try {
      final response = await ApiClient.instance.dio.get(Endpoint.getMessage+"/${2}");
      return response;
    }on DioError  catch(e){
      print("catch "+ e.response.data.toString());

    }
  }

  Future<Response> sendMessUser(String message) async{
    try{
      final res = await ApiClient.instance.dio.post(Endpoint.sendMessageUser+"/2",
          data: {
        'message':message
          });
      return res;
    }on DioError catch(e){
      print(e.response.data);
    }
  }

  Future<Response> getMessageUser() async {
    try {
      final response = await ApiClient.instance.dio.get(Endpoint.getMessageUser+"/${2}");
      return response;
    }on DioError  catch(e){
      print("catch "+ e.response.data.toString());

    }
  }
  Future<Response> updateImage(File imgFile) async{
    String fileName = imgFile.path.split('/').last;
    FormData formData = FormData.fromMap({
      'url_avata': await MultipartFile.fromFile(imgFile.path,filename: fileName),
    });
    try{
      final res = await ApiClient.instance.dio.post(Endpoint.updateUser,
          data: formData);
      return res;
    }on DioError catch(e){
      print(e.response.data);
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
      default:
        print(e.response.statusCode);
    }
  }
}
