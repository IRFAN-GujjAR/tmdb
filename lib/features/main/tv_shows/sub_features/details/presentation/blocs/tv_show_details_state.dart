part of 'tv_show_details_bloc.dart';

sealed class TvShowDetailsState extends Equatable {
  const TvShowDetailsState();
}

final class TvShowDetailsStateInitial extends TvShowDetailsState {
  @override
  List<Object> get props => [];
}

final class TvShowDetailsStateLoading extends TvShowDetailsState {
  @override
  List<Object?> get props => [];
}

final class TvShowDetailsStateLoaded extends TvShowDetailsState {
  final TvShowDetailsEntity tvShowDetails;

  TvShowDetailsStateLoaded({required this.tvShowDetails});

  @override
  List<Object?> get props => [tvShowDetails];
}

final class TvShowDetailsStateError extends TvShowDetailsState {
  final CustomErrorEntity error;

  TvShowDetailsStateError({required this.error});

  @override
  List<Object?> get props => [error];
}
