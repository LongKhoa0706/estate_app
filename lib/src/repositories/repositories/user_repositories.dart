
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:estate_app/src/model/job.dart';
import 'package:estate_app/src/model/message.dart';
import 'package:estate_app/src/model/project.dart';
import 'package:estate_app/src/model/users.dart';
import 'package:estate_app/src/repositories/provider/user_provider.dart';
import 'package:flutter/material.dart';

class UserRepositories{
  UserProvider _userProvider = UserProvider();
  int idUser;
  List<Message> listMessage = [];

  Future<Users> getUser() async {
    final userResponse =  await _userProvider.getUser();
    Users user = Users.fromJson(userResponse.data['token_data']);
    idUser = userResponse.data['token_data']['id'];
    return user;
  }

  Future<Users> getDetaillUser(int idUser) async {
   final userResponse = await _userProvider.getDetailProfile(idUser);
    Users user = Users.fromJson(userResponse.data['data']);
    return user;
  }

  Future<List<Project>> getProject(int idUser) async {
    // List<Project>listProject = [];
    final userResponse = await _userProvider.getDetailProfile(idUser);
    List listProjectt = userResponse.data['projects'];

    return listProjectt.map((e) => Project.fromJson(e)).toList();
  }
  Future<void> updateUser(String userName,String date,String personal,String firstName,String lastName) async {
    final userResponse = await _userProvider.updateUser(userName,date,personal,firstName,lastName);
    print(userResponse.data);
    return userResponse;
  }
  Future<Response>updatePasswordUser({@required String oldPassword,@required String newPassword}) async {
    final userResponse = await _userProvider.updatePassword(oldPassword, newPassword);
    return userResponse;
  }
  Future<String> updateImageUser(File image) async {
    final userResponse = await _userProvider.updateImage(image);
    String urlImage = userResponse.data['data']['url_avata'];
    return urlImage;
  }
  Future<Response> sendMessage(String message) async {
    final userResponse = await _userProvider.sendMessage(message);
    return userResponse;
  }
  Future<Response> changePassword(String email,String password,String rePassword) async {
    final userResponse = await _userProvider.changePassword(email,password,rePassword);
    return userResponse;
  }
  Future<List<Message>> getMessage() async {
     // List<Message> listMessage = [];
    final userResponse = await _userProvider.getMessage();
    List listt = userResponse.data['data'];
    listMessage = listt.map((e) => Message.fromJson(e)).toList();
    return listMessage;
  }
  Future<Response> sendMessUser(String message) async {
    final userResponse = await _userProvider.sendMessUser(message);
    return userResponse;
  }
  Future<List<Job>> getAllJob() async {
     List<Job>listJob = [];
    final userResponse = await _userProvider.getAllJob();
    List listt = userResponse.data['data'];
    listJob = listt.map((e) => Job.fromJson(e)).toList();
    return listJob;
  }
}