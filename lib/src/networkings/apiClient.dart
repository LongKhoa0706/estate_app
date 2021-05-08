import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:estate_app/src/service/share_pref.dart';
import 'package:estate_app/src/utils/const.dart';

class ApiClient{
  static BaseOptions _options = new BaseOptions(
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      },
      baseUrl: "http://nhadatchinhchu.billionaire-land.net/api/",
      connectTimeout: 60*1000, // 60 seconds
      receiveTimeout: 60*1000 );

  static Dio _dio = Dio(_options);

  ApiClient._internal() {
    _dio.interceptors.add(InterceptorsWrapper(onRequest: (Options myOption) async {
      var token = await SharedPrefService.get(key: Constant.KEY_TOKEN);
      if (token != null) {
        myOption.headers["Authorization"] = "Bearer " + token;
        // print(token);
      }
      return myOption;
    }));
  }

  static final ApiClient
  instance = ApiClient._internal();
  Dio get dio => _dio;

}