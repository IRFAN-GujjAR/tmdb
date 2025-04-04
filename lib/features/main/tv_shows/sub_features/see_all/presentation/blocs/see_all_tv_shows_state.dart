part of 'see_all_tv_shows_bloc.dart';

sealed class SeeAllTvShowsState extends Equatable {
  const SeeAllTvShowsState();
}

final class SeeAllTvShowsStateInitial extends SeeAllTvShowsState {
  @override
  List<Object> get props => [];
}

final class SeeAllTvShowsStateLoading extends SeeAllTvShowsState {
  @override
  List<Object> get props => [];
}

final class SeeAllTvShowsStateLoaded extends SeeAllTvShowsState {
  final TvShowsListEntity tvShowsList;

  SeeAllTvShowsStateLoaded(this.tvShowsList);

  @override
  List<Object?> get props => [tvShowsList];
}

final class SeeAllTvShowsStateError extends SeeAllTvShowsState {
  final CustomErrorEntity error;

  SeeAllTvShowsStateError(this.error);

  @override
  List<Object?> get props => [error];
}
