part of 'tv_show_season_details_bloc.dart';

sealed class TvShowSeasonDetailsEvent extends Equatable {
  const TvShowSeasonDetailsEvent();
}

final class TvShowSeasonDetailsEventLoad extends TvShowSeasonDetailsEvent {
  final TvShowSeasonDetailsParams params;

  TvShowSeasonDetailsEventLoad(this.params);

  @override
  List<Object> get props => [params];
}
