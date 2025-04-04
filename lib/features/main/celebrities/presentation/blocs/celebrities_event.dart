part of 'celebrities_bloc.dart';

sealed class CelebritiesEvent extends Equatable {
  const CelebritiesEvent();
}

final class CelebritiesEventLoad extends CelebritiesEvent {
  const CelebritiesEventLoad();

  @override
  List<Object?> get props => [];
}

final class CelebritiesEventUpdated extends CelebritiesEvent {
  final CelebritiesEntity celebs;

  const CelebritiesEventUpdated({required this.celebs});

  @override
  List<Object?> get props => [celebs];
}

final class CelebritiesEventRefresh extends CelebritiesEvent {
  final Completer<void> completer;

  const CelebritiesEventRefresh(this.completer);

  @override
  List<Object?> get props => [completer];
}
