part of 'like_project_bloc.dart';

@immutable
abstract class LikeProjectEvent {}

class LikeProjectEventLike extends LikeProjectEvent{
  final int idProject;

  LikeProjectEventLike(this.idProject);

}

class LikeProjectEventUnLike extends LikeProjectEvent{
  final int idProject;

  LikeProjectEventUnLike(this.idProject);

}
