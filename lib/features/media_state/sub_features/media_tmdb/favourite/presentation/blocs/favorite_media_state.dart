part of 'favorite_media_bloc.dart';

sealed class FavoriteMediaState extends Equatable {
  const FavoriteMediaState();
}

final class FavoriteMediaStateInitial extends FavoriteMediaState {
  @override
  List<Object> get props => [];
}

final class FavoriteMediaStateMarking extends FavoriteMediaState {
  @override
  List<Object?> get props => [];
}

final class FavoriteMediaStateMarked extends FavoriteMediaState {
  @override
  List<Object?> get props => [];
}

final class FavoriteMediaStateUnMarking extends FavoriteMediaState {
  @override
  List<Object?> get props => [];
}

final class FavoriteMediaStateUnMarked extends FavoriteMediaState {
  @override
  List<Object?> get props => [];
}

final class FavoriteMediaStateError extends FavoriteMediaState {
  final String errorMsg;

  FavoriteMediaStateError(this.errorMsg);

  @override
  List<Object?> get props => [errorMsg];
}
