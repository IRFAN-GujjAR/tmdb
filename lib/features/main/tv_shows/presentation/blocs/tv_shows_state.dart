part of 'tv_shows_bloc.dart';

sealed class TvShowsState extends Equatable {
  const TvShowsState();
}

final class TvShowsStateLoading extends TvShowsState {
  @override
  List<Object?> get props => [];
}

final class TvShowsStateLoaded extends TvShowsState {
  final TvShowsEntity tvShows;

  const TvShowsStateLoaded(this.tvShows);

  @override
  List<Object?> get props => [tvShows];
}

final class TvShowsStateErrorWithoutCache extends TvShowsState {
  final CustomErrorEntity error;

  const TvShowsStateErrorWithoutCache(this.error);

  @override
  List<Object?> get props => [error];
}

final class TvShowsStateErrorWithCache extends TvShowsState {
  final TvShowsEntity tvShows;
  final CustomErrorEntity error;

  const TvShowsStateErrorWithCache({
    required this.tvShows,
    required this.error,
  });

  @override
  List<Object?> get props => [tvShows, error];
}
