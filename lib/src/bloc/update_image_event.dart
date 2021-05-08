part of 'update_image_bloc.dart';

@immutable
abstract class UpdateImageEvent {}

class UploadImageEvent extends UpdateImageEvent{
  final File image;

  UploadImageEvent(this.image);

}
