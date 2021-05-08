part of 'city_bloc.dart';

@immutable
abstract class CityEvent {}

class CityEventFetching extends CityEvent {

}
class CityEventFetchDistrictByCity extends CityEvent{
  final int idCity;

  CityEventFetchDistrictByCity(this.idCity);
}