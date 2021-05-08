
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:estate_app/src/model/post.dart';
import 'package:estate_app/src/networkings/apiClient.dart';
import 'package:estate_app/src/utils/endpoint.dart';
import 'package:estate_app/src/utils/string.dart';
import 'package:http_parser/http_parser.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class PostProvider {
  Future<Response> addPost(List<Asset> listImageProject,String postContent) async{
    try{
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
      FormData formData = FormData.fromMap({
        'post_content':postContent,
        'post_image':multipart,
      });
      final response = ApiClient.instance.dio.post(Endpoint.addPost,data: formData);
      return response;
    }on DioError catch(e){
      print(e.response.statusCode);
    }
  }
  Future<Response> getAllPost(){
    try{
      final response = ApiClient.instance.dio.get(Endpoint.getAllPost,queryParameters: ({
        'limit':600,
      }));
      return response;
    }on DioError catch(e){
      print(e.response.data);
    }
  }
  Future<Response> getMyPost(){
    try{
      final response = ApiClient.instance.dio.post(Endpoint.getMyPost);
      return response;
    }on DioError catch(e){
      print(e.response.data['message']);
    }
  }



  Future<Response> likeProject(int idProject,bool isLike) async {
    try{
      final response = await ApiClient.instance.dio.post(isLike ? Endpoint.likeProject : 'un-like',data: {
        'type_like':"posts",
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
        'type_comment':'posts',
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
          'type_comment':'posts',
        });
        return response;
      }else{
        final response = await ApiClient.instance.dio.post(Endpoint.createComment,data: {
          'post_id':idProject,
          'comment_content':commentContent,
          'type_comment':'posts',
          'comment_id':idComment
        });
        return response;
      }
      // return response;
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
  Future<Response> listLikeByPost(int idPost) async {
    try{
      final response = await ApiClient.instance.dio.post(Endpoint.listLikeProject,data: {
        'post_id':idPost,
        'type_like':'posts',
      });
      return response;
    }on DioError catch(e){
      print(e.response.data);

    }
  }
  Future<Response> getPostUser(int idUser) async {
    try{
      final res = await ApiClient.instance.dio.post(Endpoint.getPostUser+"/$idUser");
      return res;
    }on DioError catch(e){
      print(e.response.data);
    }
  }
}