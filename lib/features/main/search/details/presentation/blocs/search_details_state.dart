part of 'search_details_bloc.dart';

sealed class SearchDetailsState extends Equatable {
  const SearchDetailsState();
  @override
  List<Object?> get props => [];
}

final class SearchDetailsStateInitial extends SearchDetailsState {}

final class SearchDetailsStateLoading extends SearchDetailsState {}

final class SearchDetailsStateLoaded extends SearchDetailsState {
  final SearchDetailsEntity searchDetails;

  SearchDetailsStateLoaded({required this.searchDetails});

  @override
  List<Object?> get props => [searchDetails];
}

final class SearchDetailsStateNoResultsFound extends SearchDetailsState {
  const SearchDetailsStateNoResultsFound();

  @override
  List<Object?> get props => [];
}

final class SearchDetailsStateError extends SearchDetailsState {
  final CustomErrorEntity error;

  SearchDetailsStateError({required this.error});

  @override
  List<Object?> get props => [error];
}
