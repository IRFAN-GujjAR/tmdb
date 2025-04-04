part of 'search_bloc.dart';

sealed class SearchEvent extends Equatable {
  const SearchEvent();
}

final class SearchEventLoad extends SearchEvent {
  final SearchParams params;

  SearchEventLoad({required this.params});

  @override
  List<Object?> get props => [params];
}
