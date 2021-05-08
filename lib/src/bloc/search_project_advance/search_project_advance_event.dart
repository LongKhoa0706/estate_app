part of 'search_project_advance_bloc.dart';

@immutable
abstract class SearchProjectAdvanceEvent {}

class SearchProjectAdvanceEventSubtmit extends SearchProjectAdvanceEvent {
  final String categories;
  final String minPrice;
  final String maxPrice;
  final String provincial;
  final String title;

  SearchProjectAdvanceEventSubtmit(this.categories, this.minPrice, this.maxPrice, this.provincial, this.title);
}
