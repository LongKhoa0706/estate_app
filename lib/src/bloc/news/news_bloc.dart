import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:estate_app/src/model/news.dart';
import 'package:estate_app/src/model/project.dart';
import 'package:estate_app/src/repositories/repositories.dart';
import 'package:meta/meta.dart';

part 'news_event.dart';

part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  Repositories repositories = Repositories();
  NewsBloc() : super(InitialNewsState());
  List<News> listNews = List();
  List<Project> listProject = List();

  @override
  Stream<NewsState> mapEventToState(NewsEvent event) async* {
    yield NewsStateLoading();
    try{
        if (event is NewsEventFetchingData) {
            listNews =  await repositories.homeRepositories.getNews();
            listProject = await repositories.homeRepositories.getProject();
            yield NewsStateSuccessful(listNews,listProject);
        }
    }catch(e){
      yield NewsStateFail(e.toString());
    }
  }
}
