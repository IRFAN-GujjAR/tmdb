part of 'celebrities_bloc.dart';

sealed class CelebritiesState extends Equatable {
  const CelebritiesState();
}

final class CelebritiesStateLoading extends CelebritiesState {
  @override
  List<Object?> get props => [];
}

final class CelebritiesStateLoaded extends CelebritiesState {
  final CelebritiesEntity celebrities;
  final List<CelebrityEntity> firstHalfPopular;
  final List<CelebrityEntity> secondHalfPopular;

  CelebritiesStateLoaded({
    required this.celebrities,
    required this.firstHalfPopular,
    required this.secondHalfPopular,
  });

  @override
  List<Object?> get props => [celebrities, firstHalfPopular, secondHalfPopular];
}

final class CelebritiesStateErrorWithCache extends CelebritiesState {
  final CelebritiesEntity celebrities;
  final List<CelebrityEntity> firstHalfPopular;
  final List<CelebrityEntity> secondHalfPopular;
  final CustomErrorEntity error;

  CelebritiesStateErrorWithCache({
    required this.celebrities,
    required this.firstHalfPopular,
    required this.secondHalfPopular,
    required this.error,
  });

  @override
  List<Object?> get props => [
    celebrities,
    firstHalfPopular,
    secondHalfPopular,
    error,
  ];
}

final class CelebritiesStateErrorWithoutCache extends CelebritiesState {
  final CustomErrorEntity error;

  CelebritiesStateErrorWithoutCache({required this.error});

  @override
  List<Object?> get props => [error];
}
