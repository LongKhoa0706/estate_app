part of 'list_like_post_bloc.dart';

@immutable
abstract class ListLikePostEvent {}

class ListLikePostEventFetchData extends ListLikePostEvent{
  final int idPost;

  ListLikePostEventFetchData(this.idPost);
}

