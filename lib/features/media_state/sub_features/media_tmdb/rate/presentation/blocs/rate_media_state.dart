import 'package:equatable/equatable.dart';

sealed class RateMediaState extends Equatable {
  const RateMediaState();
}

final class RateMediaStateInitial extends RateMediaState {
  @override
  List<Object?> get props => [];
}

final class RateMediaStateRating extends RateMediaState {
  @override
  List<Object?> get props => [];
}

final class RateMediaStateRated extends RateMediaState {
  @override
  List<Object?> get props => [];
}

final class RateMediaStateDeletingRating extends RateMediaState {
  @override
  List<Object?> get props => [];
}

final class RateMediaStateDeletedRating extends RateMediaState {
  @override
  List<Object?> get props => [];
}

final class RateMediaStateError extends RateMediaState {
  final String errorMsg;

  RateMediaStateError({required this.errorMsg});

  @override
  List<Object?> get props => [errorMsg];
}
