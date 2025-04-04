part of 'trending_search_bloc.dart';

sealed class TrendingSearchState extends Equatable {
  const TrendingSearchState();
}

final class TrendingSearchStateLoading extends TrendingSearchState {
  const TrendingSearchStateLoading();

  @override
  List<Object?> get props => [];
}

final class TrendingSearchStateLoaded extends TrendingSearchState {
  final SearchesEntity trendingSearch;

  const TrendingSearchStateLoaded({required this.trendingSearch});

  @override
  List<Object?> get props => [trendingSearch];
}

final class TrendingSearchStateErrorWithCache extends TrendingSearchState {
  final SearchesEntity trendingSearch;
  final CustomErrorEntity error;

  const TrendingSearchStateErrorWithCache({
    required this.trendingSearch,
    required this.error,
  });

  @override
  List<Object?> get props => [trendingSearch, error];
}

final class TrendingSearchStateErrorWithoutCache extends TrendingSearchState {
  final CustomErrorEntity error;

  const TrendingSearchStateErrorWithoutCache({required this.error});

  @override
  List<Object?> get props => [error];
}
