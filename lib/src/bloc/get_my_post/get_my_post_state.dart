part of 'get_my_post_bloc.dart';

@immutable
abstract class GetMyPostState {}

class InitialGetMyPostState extends GetMyPostState {}

class GetMyPostStateLoading extends GetMyPostState{}

class GetMyPostStateSuccess extends GetMyPostState{
  final List<Post> listMyPost;

  GetMyPostStateSuccess(this.listMyPost);
}

class GetMyPostStateFail extends GetMyPostState{
  final dynamic error;

  GetMyPostStateFail(this.error);
}