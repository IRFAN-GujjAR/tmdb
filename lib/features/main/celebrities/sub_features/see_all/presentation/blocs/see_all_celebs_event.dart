part of 'see_all_celebs_bloc.dart';

sealed class SeeAllCelebsEvent extends Equatable {
  const SeeAllCelebsEvent();
}

final class SeeAllCelebsEventLoad extends SeeAllCelebsEvent {
  final Map<String, dynamic> params;

  SeeAllCelebsEventLoad(this.params);

  @override
  List<Object?> get props => [params];
}
