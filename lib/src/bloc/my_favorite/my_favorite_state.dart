part of 'my_favorite_bloc.dart';

@immutable
abstract class MyFavoriteState {}

class InitialMyFavoriteState extends MyFavoriteState {}

class MyFavoriteStateLoading extends MyFavoriteState{}

class MyFavoriteStateSuccess extends MyFavoriteState{
  final List<Project> listMyLike;

  MyFavoriteStateSuccess(this.listMyLike);
}
class MyFavoriteStateFail extends MyFavoriteState{
  final dynamic error;

  MyFavoriteStateFail(this.error);
}