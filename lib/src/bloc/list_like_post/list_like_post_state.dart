part of 'list_like_post_bloc.dart';

@immutable
abstract class ListLikePostState {}

class InitialListLikePostState extends ListLikePostState {}

class ListLikePostStateLoading extends ListLikePostState{}

class ListLikePostStateSuccess extends ListLikePostState{
  final List<Users> listLikeUser;

  ListLikePostStateSuccess(this.listLikeUser);
}

class ListLikePostStateFail extends ListLikePostState{
  final dynamic error;

  ListLikePostStateFail(this.error);

}