part of 'city_bloc.dart';

@immutable
abstract class CityState {}

class InitialCityState extends CityState {}

class CityStateLoading extends CityState {}

class CityStateSuccessCity extends CityState{
 final List<Address> listCity;

  CityStateSuccessCity(this.listCity);
}

class CityStateSuccessDistrict extends CityState{

}