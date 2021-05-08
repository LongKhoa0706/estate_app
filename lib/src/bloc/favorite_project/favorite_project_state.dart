part of 'favorite_project_bloc.dart';

@immutable
abstract class FavoriteProjectState {}

class InitialFavoriteProjectState extends FavoriteProjectState {}

class FavoriteProjectStateLoading extends FavoriteProjectState{}

class FavoriteProjectStateSuccess extends FavoriteProjectState{
  final List<FavoriteProject> listFavoriteProject;

  FavoriteProjectStateSuccess(this.listFavoriteProject);

}
class FavoriteProjectStateFail extends FavoriteProjectState{
  final dynamic error;

  FavoriteProjectStateFail(this.error);

}