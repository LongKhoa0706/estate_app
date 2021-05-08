part of 'list_like_project_bloc.dart';

@immutable
abstract class ListLikeProjectState {}

class InitialListLikeProjectState extends ListLikeProjectState {}

class ListLikeProjectStateLoading extends ListLikeProjectState{}

class ListLikeProjectStateSuccess extends ListLikeProjectState {
  final List<Users> listUser;

  ListLikeProjectStateSuccess(this.listUser);
}

class ListLikeProjectStateFail extends ListLikeProjectState{
  final dynamic error;

  ListLikeProjectStateFail(this.error);

}