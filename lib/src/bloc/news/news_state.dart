part of 'news_bloc.dart';

@immutable
abstract class NewsState {}

class InitialNewsState extends NewsState {}

class NewsStateLoading extends NewsState {}

class NewsStateSuccessful extends NewsState{
  final List<News> listNews;
  final List<Project> listProject;


  NewsStateSuccessful(this.listNews, this.listProject);
}


class NewsStateFail extends NewsState {
  final dynamic err;

  NewsStateFail(this.err);

}