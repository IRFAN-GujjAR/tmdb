import 'package:equatable/equatable.dart';
import 'package:tmdb/features/main/tmdb/sub_features/media_list/domain/entities/tmdb_media_list_entity.dart';

import '../../../../../../../core/entities/error/custom_error_entity.dart';

sealed class TMDbMediaListState extends Equatable {
  const TMDbMediaListState();

  @override
  List<Object> get props => [];
}

final class TMDbMediaListStateInitial extends TMDbMediaListState {}

final class TMDbMediaListStateLoading extends TMDbMediaListState {}

final class TMDbMediaListStateLoaded extends TMDbMediaListState {
  final TMDbMediaListEntity tMDBMediaList;

  TMDbMediaListStateLoaded(this.tMDBMediaList);

  @override
  List<Object> get props => [tMDBMediaList];
}

final class TMDbMediaListStateEmpty extends TMDbMediaListState {}

final class TMDbMediaListStateError extends TMDbMediaListState {
  final CustomErrorEntity error;

  TMDbMediaListStateError(this.error);

  @override
  List<Object> get props => [error];
}
