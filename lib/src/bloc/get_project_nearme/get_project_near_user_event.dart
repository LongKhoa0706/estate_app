part of 'get_project_near_user_bloc.dart';

@immutable
abstract class GetProjectNearUserEvent {}

class GetProjectNearUserEventFetchDataNear extends GetProjectNearUserEvent{
  final double lat,lng;
  final int distance;

  GetProjectNearUserEventFetchDataNear(this.lat, this.lng, this.distance);
}
