part of 'add_post_bloc.dart';

@immutable
abstract class AddPostEvent {}

class AddPostEventSubmit extends AddPostEvent{
  final String content;
  final List<Asset> listImageProject;

  AddPostEventSubmit(this.content, this.listImageProject);
}
