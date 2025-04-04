part of 'tv_show_details_bloc.dart';

sealed class TvShowDetailsEvent extends Equatable {
  const TvShowDetailsEvent();
}

final class TvShowDetailsEventLoad extends TvShowDetailsEvent{
  final int tvId;

  TvShowDetailsEventLoad({required this.tvId});

  @override
  List<Object?> get props =>[tvId];
}