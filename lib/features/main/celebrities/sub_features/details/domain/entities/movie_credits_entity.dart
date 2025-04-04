import 'package:equatable/equatable.dart';

import '../../../../../../../core/entities/movie/movie_entity.dart';

class MovieCreditsEntity extends Equatable {
  final List<MovieEntity> cast;
  final List<MovieEntity> crew;

  MovieCreditsEntity({required this.cast, required this.crew});

  @override
  List<Object?> get props => [cast, crew];
}
