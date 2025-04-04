import 'package:equatable/equatable.dart';
import 'package:tmdb/core/entities/tv_show/tv_show_entity.dart';

final class TvShowCreditsEntity extends Equatable {
  final List<TvShowEntity> cast;
  final List<TvShowEntity> crew;

  TvShowCreditsEntity({required this.cast, required this.crew});

  @override
  List<Object?> get props => [cast, crew];
}
