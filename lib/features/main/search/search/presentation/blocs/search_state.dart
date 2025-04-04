part of 'search_bloc.dart';

sealed class SearchState extends Equatable {
  const SearchState();
}

final class SearchStateInitial extends SearchState {
  @override
  List<Object> get props => [];
}

final class SearchStateLoading extends SearchState {
  @override
  List<Object?> get props => [];
}

final class SearchStateLoaded extends SearchState {
  final SearchesEntity searchesEntity;

  SearchStateLoaded({required this.searchesEntity});

  @override
  List<Object?> get props => [searchesEntity];
}

final class SearchStateNoItemsFound extends SearchState {
  const SearchStateNoItemsFound();
  @override
  List<Object?> get props => [];
}

final class SearchStateError extends SearchState {
  final CustomErrorEntity error;

  SearchStateError({required this.error});

  @override
  List<Object?> get props => [error];
}
