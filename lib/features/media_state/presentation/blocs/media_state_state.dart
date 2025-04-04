import 'package:equatable/equatable.dart';
import 'package:tmdb/core/entities/error/custom_error_entity.dart';
import 'package:tmdb/features/media_state/domain/entities/media_state_entity.dart';

sealed class MediaStateState extends Equatable {
  const MediaStateState();
}

final class MediaStateStateInitial extends MediaStateState {
  @override
  List<Object?> get props => [];
}

final class MediaStateStateLoading extends MediaStateState {
  @override
  List<Object?> get props => [];
}

final class MediaStateStateLoaded extends MediaStateState {
  final MediaStateEntity mediaState;

  MediaStateStateLoaded({required this.mediaState});

  @override
  List<Object?> get props => [mediaState];
}

final class MediaStateStateError extends MediaStateState {
  final CustomErrorEntity error;

  MediaStateStateError({required this.error});

  @override
  List<Object?> get props => [error];
}
