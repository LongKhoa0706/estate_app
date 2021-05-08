part of 'add_new_bloc.dart';

@immutable
abstract class AddNewEvent {}

class AddNewEventSubmit extends AddNewEvent{
  final New news;

  AddNewEventSubmit(this.news);

}
