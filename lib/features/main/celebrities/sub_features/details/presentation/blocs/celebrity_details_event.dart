import 'package:equatable/equatable.dart';

sealed class CelebrityDetailsEvent extends Equatable {
  const CelebrityDetailsEvent();
}

final class CelebrityDetailsEventLoad extends CelebrityDetailsEvent {
  final int celebId;

  CelebrityDetailsEventLoad(this.celebId);

  @override
  List<Object?> get props => [celebId];
}
