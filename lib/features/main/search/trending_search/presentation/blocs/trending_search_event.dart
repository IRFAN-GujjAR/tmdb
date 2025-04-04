part of 'trending_search_bloc.dart';

sealed class TrendingSearchEvent extends Equatable {
  const TrendingSearchEvent();
}

final class TrendingSearchEventLoad extends TrendingSearchEvent {
  const TrendingSearchEventLoad();

  @override
  List<Object?> get props => [];
}

final class TrendingSearchEventUpdated extends TrendingSearchEvent {
  final SearchesEntity trendingSearch;

  const TrendingSearchEventUpdated(this.trendingSearch);

  @override
  List<Object?> get props => [trendingSearch];
}

final class TrendingSearchEventRefresh extends TrendingSearchEvent {
  final Completer<void> completer;

  const TrendingSearchEventRefresh(this.completer);

  @override
  List<Object?> get props => [completer];
}
