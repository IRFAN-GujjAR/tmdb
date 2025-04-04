part of 'see_all_tv_shows_bloc.dart';

sealed class SeeAllTvShowsEvent extends Equatable {
  const SeeAllTvShowsEvent();
}

final class SeeAllTvShowsEventLoad extends SeeAllTvShowsEvent {
  final SeeAllTvShowsParams params;

  SeeAllTvShowsEventLoad({required this.params});

  @override
  List<Object?> get props => [params];
}
