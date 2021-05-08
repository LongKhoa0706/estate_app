part of 'add_post_bloc.dart';

@immutable
abstract class AddPostState {}

class InitialAddPostState extends AddPostState {}

class AddPostStateLoading extends AddPostState{}

class AddPostStateSuccess extends AddPostState{}

class AddPostStateFail extends AddPostState{
  final dynamic error;

  AddPostStateFail(this.error);

}