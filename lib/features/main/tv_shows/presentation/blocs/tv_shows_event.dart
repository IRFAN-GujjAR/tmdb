part of 'tv_shows_bloc.dart';

sealed class TvShowsEvent extends Equatable {
  const TvShowsEvent();
}

final class TvShowsEventLoad extends TvShowsEvent {
  @override
  List<Object?> get props => [];
}

final class TvShowsEventUpdated extends TvShowsEvent {
  final TvShowsEntity tvShows;

  const TvShowsEventUpdated(this.tvShows);

  @override
  List<Object?> get props => [tvShows];
}

final class TvShowsEventRefresh extends TvShowsEvent {
  final Completer<void> completer;

  const TvShowsEventRefresh(this.completer);

  @override
  List<Object?> get props => [completer];
}
