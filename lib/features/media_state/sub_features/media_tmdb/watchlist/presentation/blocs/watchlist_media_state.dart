part of 'watchlist_media_bloc.dart';

sealed class WatchlistMediaState extends Equatable {
  const WatchlistMediaState();
}

final class WatchlistMediaStateInitial extends WatchlistMediaState {
  const WatchlistMediaStateInitial();

  @override
  List<Object?> get props => [];
}

final class WatchlistMediaStateAdding extends WatchlistMediaState {
  const WatchlistMediaStateAdding();

  @override
  List<Object?> get props => [];
}

final class WatchlistMediaStateAdded extends WatchlistMediaState {
  const WatchlistMediaStateAdded();

  @override
  List<Object?> get props => [];
}

final class WatchlistMediaStateRemoving extends WatchlistMediaState {
  const WatchlistMediaStateRemoving();

  @override
  List<Object?> get props => [];
}

final class WatchlistMediaStateRemoved extends WatchlistMediaState {
  const WatchlistMediaStateRemoved();

  @override
  List<Object?> get props => [];
}

final class WatchlistMediaStateError extends WatchlistMediaState {
  final String errorMsg;

  const WatchlistMediaStateError({required this.errorMsg});

  @override
  List<Object?> get props => [errorMsg];
}
