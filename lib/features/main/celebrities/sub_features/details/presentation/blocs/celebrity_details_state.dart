import 'package:equatable/equatable.dart';
import 'package:tmdb/core/entities/error/custom_error_entity.dart';

import '../../domain/entities/celebrity_details_entity.dart';

sealed class CelebrityDetailsState extends Equatable {
  const CelebrityDetailsState();

  @override
  List<Object?> get props => [];
}

final class CelebrityDetailsStateInitial extends CelebrityDetailsState {}

final class CelebrityDetailsStateLoading extends CelebrityDetailsState {}

final class CelebrityDetailsStateLoaded extends CelebrityDetailsState {
  final CelebrityDetailsEntity celebrityDetails;

  CelebrityDetailsStateLoaded(this.celebrityDetails);

  @override
  List<Object?> get props => [celebrityDetails];
}

final class CelebrityDetailsStateError extends CelebrityDetailsState {
  final CustomErrorEntity error;

  CelebrityDetailsStateError(this.error);

  @override
  List<Object?> get props => [error];
}
