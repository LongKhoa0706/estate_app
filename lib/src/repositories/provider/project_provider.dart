



import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:estate_app/src/model/project.dart';
import 'package:estate_app/src/model/users.dart';
import 'package:estate_app/src/networkings/apiClient.dart';
import 'package:estate_app/src/utils/endpoint.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:http_parser/http_parser.dart';

import 'package:multi_image_picker/multi_image_picker.dart';

class ProjectProvider{
  Future<Response> createProject(Project project,File urlLogo,List<Asset> listImageProject) async {
    try {
      List<MultipartFile> multipart = List<MultipartFile>();
      if (null != listImageProject) {
        for (Asset asset in listImageProject) {
          ByteData byteData = await asset.getByteData();
          List<int> imageData = byteData.buffer.asUint8List();
          MultipartFile multipartFile = new MultipartFile.fromBytes(
            imageData,
            filename: 'load_image',
            contentType: MediaType('image', 'jpg'),
          );
          multipart.add(multipartFile);
        }
      }

      String fileName = urlLogo.path.split('/').last;
      FormData dataa = FormData.fromMap({
        'news_logo': [await MultipartFile.fromFile(
          urlLogo.path,
          filename: fileName,
            contentType: MediaType("image", "jpg")
        ),
        ],
        'news_image': multipart,
        'news_title': project.newsTitle,
        'news_description':project.newsDescription,
        'news_type': project.newsType,
        'news_price_from': project.newsPriceFrom,
        'news_price_meters_from': project.newsPriceFrom,
        'news_investment': project.newsInvestment,
        'news_building_density': project.newsBuildingDensity,
        'news_land_area': project.newsLandArea,
        'news_street':project.newsStreet,
        'news_ward':project.newsWard,
        'news_province':project.newsProvince,
        'news_district':project.newsDistrict,
        'news_project': project.newsProject,
        'news_lat':project.lat,
        'news_lng':project.lng,
      });
      final response = await ApiClient.instance.dio.post(Endpoint.createProject,data: dataa);
      return response;
    }on DioError catch (e){
      print('project1 '+ e.response.statusCode.toString());
    }
  }

  Future<Response> getAllProject() async {
    try {
      final res = await ApiClient.instance.dio.post(
        Endpoint.getProject,
      );
      print(res.data);

      return res;
    } on DioError catch (e) {
      print(e.response.data);
    }
  }

  Future<Response> getMyProject() async {
    try{
      final response = await ApiClient.instance.dio.post(Endpoint.getMyProject);
      return response;
    }on DioError catch(e){
      print(e.response.data);
    }
  }
  Future<Response> detailProject(int idProject) async {
    try{
      final response = await ApiClient.instance.dio.get(Endpoint.getDetailProject+'/$idProject');
      return response;
    }on DioError catch(e){
      print(e.response.statusMessage);
    }
  }
  Future<Response> listLikeByProject(int idProject) async {
    try{
      final response = await ApiClient.instance.dio.post(Endpoint.listLikeProject,data: {
        'post_id':idProject,
        'type_like':'news',
      });
      return response;
    }on DioError catch(e){
      print(e.response.data);

    }
  }
  Future<Response> deleteProject(int idProject) async {
    try{
      final response = await ApiClient.instance.dio.get(Endpoint.deleteProject+'/$idProject');
      return response;
    }on DioError catch(e){
      print(e.response.data);
    }
  }

  Future<Response> likeProject(int idProject,bool isLike) async {
    try{
      final response = await ApiClient.instance.dio.post(isLike ? Endpoint.likeProject : 'un-like',data: {
        'type_like':"news",
        'post_id':idProject,
      });
      return response;
    }on DioError catch(e){
      print(e.toString());
    }
  }
  Future<Response> listCommentByProject(int idProject) async {
    try{
      final response = await ApiClient.instance.dio.post(Endpoint.listComment,data: {
        'post_id':idProject,
        'type_comment':'news',
        'limit':200
      });
      return response;
    }on DioError catch (e){
      print(e.response.data);
    }
  }
  Future<Response> createComment(int idProject,String commentContent,int idComment) async {
    try{
      if (idComment == 0 ) {
        final response = await ApiClient.instance.dio.post(Endpoint.createComment,data: {
          'post_id':idProject,
          'comment_content':commentContent,
          'type_comment':'news',
        });
        return response;
      }else{
        final response = await ApiClient.instance.dio.post(Endpoint.createComment,data: {
          'post_id':idProject,
          'comment_content':commentContent,
          'type_comment':'news',
          'comment_id':idComment
        });
        return response;
      }
      // return response;
    }on DioError catch(e){
      print(e.response.data);
    }
  }
  Future<Response> likeCommentProject(int idComment) async {
    try{
      final response = await ApiClient.instance.dio.post(Endpoint.likeCommentProject,data: {
        'id_comment':idComment,
      });
      return response;
    }on DioError catch(e){
      print(e.response.data);
    }
  }
  Future<Response> listLikeComment(int id_comment) async {
    try{
      final response = await ApiClient.instance.dio.post(Endpoint.listLikeComment,data: ({
        'id_comment':id_comment,
      }));
      return response;
    }on DioError catch(e){
      print(e.response.data);
    }
  }

  Future<Response> listReplyComment(int idProject,int idComment) async {
    try{
      final reponse = await ApiClient.instance.dio.post(Endpoint.listReplyComment,data: ({
        'post_id':idProject,
        'comment_id':idComment,
        'type_comment':'news',
      }));

      return reponse;
    }on DioError catch(e){
      print(e.response.data);
    }
  }
  Future<Response> updateProject(int idProject,Project project) async {
    try{
      FormData dataa = FormData.fromMap(project.toJson());
      final response = await ApiClient.instance.dio.post(Endpoint.updateProject+"/$idProject",data: dataa);
      return response;
    }on DioError catch(e){
      print(e.response.data);

    }
  }
  Future<Response> listProjectMyLike() async {
    ApiClient.instance.dio;
    try{
      final respinse = await ApiClient.instance.dio.get(Endpoint.projectMyLike);
      return respinse;
    }on DioError catch(e){
      print(e.response.data);
    }
  }

  Future<Response> apiSearchResponse(String typeSearch,String keyWord,String typeSearch2,String keyword2) async {
   var respone = await  ApiClient.instance.dio.get(Endpoint.searchProject+"?$typeSearch=$keyWord&$typeSearch2=$keyword2");
   return respone;
  }


  Future<Response> searchProject(String keyWord,String optionSearch,String keyword2,String typeSearch2) async {
    try{
      switch(optionSearch){
        case "type":
          final response = await apiSearchResponse('type', keyWord,null,null);
          return response;
          break;
        case "provincials":
          final response = await apiSearchResponse('provincials', keyWord,typeSearch2,keyword2);
          print(response);
          return response;
          break;
        case "news_title":
          final response = await apiSearchResponse('news_title', keyWord,typeSearch2,keyword2);
          print(response);
          return response;
          break;
      }
    }on DioError catch(e){
      print(e.response.data);
    }
  }
  Future<Response> getAllProjectLease(String type) async {
    try {
      final res = await ApiClient.instance.dio.post(
        Endpoint.getProjectLease,
        data: {
          'type':type
        }
      );
      return res;
    } on DioError catch (e) {
      print(e.response.data);
    }
  }

  Future<Response> searchProjectAdvance(String categories,String title,String minPrice,String maxPrice,String provincial) async {
    print("RESSSSSS"+title);
    try {
      final res = await ApiClient.instance.dio.get(
          Endpoint.searchProject+"?min=$minPrice&max=$maxPrice&news_type=$categories&provincials=$provincial&news_title=$title",
      );
      return res;
    } on DioError catch (e) {
      print(e.response.data);
    }
  }

  Future<Response> getFavoriteProject() async {
    try{
      final res = await ApiClient.instance.dio.get(Endpoint.getFavoriteProject);
      return res;
    }on DioError catch(e){
      print(e.response.data);
    }
  }
  Future<Response> getProjectNearUser(double lat,double lng,int distance) async {
    try{
      final res = await ApiClient.instance.dio.post(Endpoint.getProjectNearUser,data: {
        'lat':lat,
        'lng':lng,
        'distance':distance,
      });
      print(res.data);
      return res;
    }on DioError catch(e){
      print(e.response.data);
    }
  }
  Future<Response> getProjectUser(int idUser) async {
    try{
      final res = await ApiClient.instance.dio.post(Endpoint.getProjectUser+"/$idUser");
      return res;
    }on DioError catch(e){
      print(e.response.data);
    }
  }

}