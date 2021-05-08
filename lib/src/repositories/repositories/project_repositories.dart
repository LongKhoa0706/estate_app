

import 'dart:io';

import 'package:estate_app/src/model/comment.dart';
import 'package:estate_app/src/model/favoriteproject.dart';
import 'package:estate_app/src/model/project.dart';
import 'package:estate_app/src/model/users.dart';
import 'package:estate_app/src/repositories/provider/project_provider.dart';
import 'package:estate_app/src/utils/string.dart';
import 'package:geocoder/geocoder.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class ProjectRepositories {
  ProjectProvider projectProvider = ProjectProvider();

  Future<void> createProjectt(Project project,File urlLogo,List<Asset> listImageProject) async {
    final projectResponse = await projectProvider.createProject(project,urlLogo,listImageProject);
    return projectResponse;
  }
  Future<List<Project>> getAllProject() async {
    List<Project>listProject = [];
    final projectResponse = await projectProvider.getAllProject();
    List listProjectt = projectResponse.data['data'];
    listProject = listProjectt.map((e) => Project.fromJson(e)).toList();
    return listProject;
  }
  Future<List<Project>> getMyProject() async {
    List<Project>listMyProject = [];
    final projectResponse = await projectProvider.getMyProject();
    List listMyProjectt = projectResponse.data['data'];
    listMyProject = listMyProjectt.map((e) => Project.fromJson(e)).toList();
    return listMyProject;
  }
  Future<Project> detailProject(int idProject) async {
    final projectResponse = await projectProvider.detailProject(idProject);
    Project project = Project.fromJson(projectResponse.data['data']);
    return project;
  }

  Future<void> deleteProject(int idProject) async {
    final projectResponse = await projectProvider.deleteProject(idProject);
    return projectResponse;
  }

  Future<List<Users>> listLikeProject(int idProject) async {
    List<Users>listUser = [];
    final projectResponse  = await projectProvider.listLikeByProject(idProject);
    List listUserr = projectResponse.data['data'];
    listUser = listUserr.map((e) => Users.fromJson(e['id_account_like'])).toList();
    return listUser;
  }

  Future<void> likeProject(int idProject,bool isLike) async {
    final projectResponse = await projectProvider.likeProject(idProject,isLike);
    return projectResponse;
  }

  Future<List<Comment>> listCommentByProject(int idProject) async {
    List<Comment> listComment = [];
    final projectResponse = await projectProvider.listCommentByProject(idProject);
    List listCommentt = projectResponse.data['data'];
    listComment = listCommentt.map((e) => Comment.fromJson(e)).toList();
    return listComment;
  }
  Future<void> createComment(int idProject,String content,int idComment) async {
    final projectResponse = await projectProvider.createComment(idProject, content,idComment);
    return projectResponse;
  }
  Future<void> likeCommentProject(int idComment) async {
    final projectResponse = await projectProvider.likeCommentProject(idComment);
    return projectResponse;
  }

  Future<List<Users>> listLikeComment(int idComment) async {
    List<Users> listLikeComment = [];
    final projectResponse = await projectProvider.listLikeComment(idComment);
    List listLikeCommentt = projectResponse.data['data'];
    for(int i = 0; i< listLikeCommentt.length;i++){
      final res = listLikeCommentt[i]['user_id'];
      Users user = Users.fromJson(res);
      listLikeComment.add(user);
    }
    return listLikeComment;
  }
  Future<List<Comment>> listReplyComment(int idProject,int idComment) async {
    List<Comment> listReplyComment = [];
    final projectResponse = await projectProvider.listReplyComment(idProject,idComment);
    List listReplyCommentt = projectResponse.data['data'];
    listReplyComment = listReplyCommentt.map((e) => Comment.fromJson(e)).toList();
    return listReplyComment;
  }

  Future<void> updateProject(int idProject,Project project) async {
    final projectResponse = await projectProvider.updateProject(idProject, project);
    print(projectResponse.data);
    return projectResponse;
  }
  Future<List<Project>> listProjectMyLike() async {
    List<Project> listProjectMylike = [];
    final projectResponse = await projectProvider.listProjectMyLike();
    List listProjectMylikee = projectResponse.data['data'];

    for(int i = 0 ; i<listProjectMylikee.length; i++){
      final res = listProjectMylikee[i]['id_news'];
      Project project = Project.fromJson(res);
      listProjectMylike.add(project);
    }
    return listProjectMylike;
  }
  Future<List<Project>> searchProject(String typeSearch2,String keyWord,String optionSearch,String keyword2) async {
    List<Project> listSearchProject = [];
    final projectResponse = await projectProvider.searchProject(keyWord,optionSearch,keyword2,typeSearch2);
    List listSearchProjectt = projectResponse.data['data'];
    listSearchProject = listSearchProjectt.map((e) => Project.fromJson(e)).toList();
    return listSearchProject;
  }

  Future<List<Project>> serachProjectAdvance(String categories,String title,String minPrice,String maxPrice,String provincial) async {
    List<Project> listSearchProject = [];
    final projectResponse = await projectProvider.searchProjectAdvance(categories,title,minPrice,maxPrice,provincial);
    List listSearchProjectt = projectResponse.data['data'];
    listSearchProject = listSearchProjectt.map((e) => Project.fromJson(e)).toList();
    return listSearchProject;
  }

  Future<List<Project>> getAllProjectLease(String type) async {
    List<Project>listProject = [];
    final projectResponse = await projectProvider.getAllProjectLease(type);
    List listProjectt = projectResponse.data['data'];
    listProject = listProjectt.map((e) => Project.fromJson(e)).toList();
    return listProject;
  }

  Future<List<FavoriteProject>> getFavoriteProject() async {
    List<FavoriteProject> listTop = [];
    final projectResponse = await projectProvider.getFavoriteProject();
    List listProject = projectResponse.data['data'];
    for(int i = 0 ; i<listProject.length; i++){
      final res = listProject[i];
      FavoriteProject project = FavoriteProject.fromJson(res);
      listTop.add(project);
    }
    return listTop;
  }
  Future<List<Project>> getProjectNearUser(double lat,double lng,int distance) async {
    List<Project> listProject = [];
    final projectResponse = await projectProvider.getProjectNearUser(lat, lng, distance);
    List listProjectt = projectResponse.data['data'];
    listProject = listProjectt.map((e) => Project.fromJson(e)).toList();
    return listProject;
  }

  Future<List<Project>> getProjectUser(int idUser) async {
    List<Project>listProject = [];
    final projectResponse = await projectProvider.getProjectUser(idUser);
    List listProjectt = projectResponse.data['data'];
    listProject = listProjectt.map((e) => Project.fromJson(e)).toList();
    return listProject;
  }
}