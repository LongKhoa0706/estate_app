part of 'update_image_bloc.dart';

@immutable
abstract class UpdateImageState {}

class UpdateImageInitial extends UpdateImageState {}

class UpdateImageLoading extends UpdateImageState {}

class UpdateImageStateSuccess extends UpdateImageState{
  final String urlImage;

  UpdateImageStateSuccess(this.urlImage);

}

class UpdateImageStateFail extends UpdateImageState{
  final dynamic error;

  UpdateImageStateFail(this.error);

}