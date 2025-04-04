import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:tmdb/features/main/movies/domain/entities/movies_entity.dart';

sealed class MoviesEvent extends Equatable {
  const MoviesEvent();
}

final class MoviesEventLoad extends MoviesEvent {
  @override
  List<Object?> get props => [];
}

final class MoviesEventUpdated extends MoviesEvent {
  final MoviesEntity movies;

  const MoviesEventUpdated({required this.movies});

  @override
  List<Object?> get props => [movies];
}

final class MoviesEventRefresh extends MoviesEvent {
  final Completer<void> completer;

  const MoviesEventRefresh(this.completer);

  @override
  List<Object?> get props => [completer];
}
