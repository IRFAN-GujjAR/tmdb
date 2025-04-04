part of 'see_all_celebs_bloc.dart';

sealed class SeeAllCelebsState extends Equatable {
  const SeeAllCelebsState();
  @override
  List<Object> get props => [];
}

final class SeeAllCelebsStateInitial extends SeeAllCelebsState {}

final class SeeAllCelebsStateLoading extends SeeAllCelebsState {}

final class SeeAllCelebsStateLoaded extends SeeAllCelebsState {
  final CelebritiesListEntity celebritiesList;

  SeeAllCelebsStateLoaded(this.celebritiesList);

  @override
  List<Object> get props => [celebritiesList];
}

final class SeeAllCelebsStateError extends SeeAllCelebsState {
  final CustomErrorEntity error;
  SeeAllCelebsStateError(this.error);
  @override
  List<Object> get props => [error];
}
