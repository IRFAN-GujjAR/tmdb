import 'package:equatable/equatable.dart';

final class TvShowSeasonDetailsParams extends Equatable {
  final int tvId;
  final int seasonNo;

  TvShowSeasonDetailsParams({required this.tvId, required this.seasonNo});

  @override
  List<Object?> get props => [tvId, seasonNo];
}
