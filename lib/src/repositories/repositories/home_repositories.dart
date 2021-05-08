import 'package:estate_app/src/model/news.dart';
import 'package:estate_app/src/model/project.dart';
import 'package:estate_app/src/repositories/provider/home_provider.dart';

class HomeRepositories{
  HomeProvider homeProvider = HomeProvider();
  Future<List<News>> getNews() async {
    List<News> listNews = [];
    final authResponse = await homeProvider.getNews();
    List listNewss = authResponse.data['data'];
    listNews = listNewss.map((e) => News.fromJson(e)).toList();
    return listNews;
  }
  Future<List<Project>> getProject() async {
    List<Project>listProject = [];
    final authResponse = await homeProvider.getProject();
    List listProjectt = authResponse.data['data'];
    listProject = listProjectt.map((e) => Project.fromJson(e)).toList();
    return listProject;
  }

  Future<List<String>> getBanner() async {
    List<String> listString = [];
    final authResponse = await homeProvider.getBannerProject();
    List listImage = authResponse.data['data'];
    for(int i = 0 ; i<listImage.length; i++){
      final res = listImage[i]['img_banner'];
      listString.add(res);
    }
    return listString;
  }

}