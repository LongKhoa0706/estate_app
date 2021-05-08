part of 'search_project_bloc.dart';

@immutable
abstract class SearchProjectEvent {}

class SearchProjectEventSubmit extends SearchProjectEvent{
  final String keyWord;
  final String typeSearch2;
  final String typeOptionSearch;
  final String keyword2;


  SearchProjectEventSubmit(this.keyWord, this.typeOptionSearch, this.keyword2, this.typeSearch2);
}