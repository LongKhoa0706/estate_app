part of 'get_all_post_bloc.dart';

@immutable
abstract class GetAllPostState {}

class InitialGetAllPostState extends GetAllPostState {}

class GetAllPostStateLoading extends GetAllPostState{}

class GetAllPostStateSuccess extends GetAllPostState{
  final List<Post> listPost;

  GetAllPostStateSuccess(this.listPost);
}

class GetAllPostStateFail extends GetAllPostState{
  final dynamic error;

  GetAllPostStateFail(this.error);
}