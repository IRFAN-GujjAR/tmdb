import 'package:equatable/equatable.dart';
import 'package:tmdb/core/entities/tv_show/tv_show_entity.dart';

class TvShowsListEntity extends Equatable {
  final int pageNo;
  final int totalPages;
  final List<TvShowEntity> tvShows;

  TvShowsListEntity(
      {required this.pageNo, required this.totalPages, required this.tvShows});

  @override
  List<Object?> get props => [pageNo, totalPages, tvShows];
}
