part of 'tv_show_season_details_bloc.dart';

sealed class TvShowSeasonDetailsState extends Equatable {
  const TvShowSeasonDetailsState();
  @override
  List<Object> get props => [];
}

final class TvShowSeasonDetailsStateInitial extends TvShowSeasonDetailsState {}

final class TvShowSeasonDetailsStateLoading extends TvShowSeasonDetailsState {}

final class TvShowSeasonDetailsStateLoaded extends TvShowSeasonDetailsState {
  final TvShowSeasonDetailsEntity tvShowSeasonDetails;

  TvShowSeasonDetailsStateLoaded(this.tvShowSeasonDetails);

  @override
  List<Object> get props => [tvShowSeasonDetails];
}

final class TvShowSeasonDetailsStateError extends TvShowSeasonDetailsState {
  final CustomErrorEntity error;

  TvShowSeasonDetailsStateError(this.error);

  @override
  List<Object> get props => [error];
}
