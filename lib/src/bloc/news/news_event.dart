part of 'news_bloc.dart';

@immutable
abstract class NewsEvent {}

class NewsEventFetchingData extends NewsEvent{

  NewsEventFetchingData();

}