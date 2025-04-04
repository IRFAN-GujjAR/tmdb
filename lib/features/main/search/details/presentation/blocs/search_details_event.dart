part of 'search_details_bloc.dart';

sealed class SearchDetailsEvent extends Equatable {
  const SearchDetailsEvent();
}

final class SearchDetailsEventLoad extends SearchDetailsEvent {
  final String query;

  SearchDetailsEventLoad(this.query);

  @override
  List<Object?> get props => [query];
}
