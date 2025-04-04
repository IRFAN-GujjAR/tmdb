import 'package:equatable/equatable.dart';

import '../../../../../core/entities/tv_show/tv_shows_list_entity.dart';

class TvShowsEntity extends Equatable {
  final TvShowsListEntity airingToday;
  final TvShowsListEntity trending;
  final TvShowsListEntity topRated;
  final TvShowsListEntity popular;

  TvShowsEntity(
      {required this.airingToday,
      required this.trending,
      required this.topRated,
      required this.popular});

  @override
  List<Object?> get props => [airingToday, trending, topRated, popular];
}
