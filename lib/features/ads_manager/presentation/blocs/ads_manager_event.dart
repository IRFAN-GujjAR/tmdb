import 'package:equatable/equatable.dart';
import 'package:tmdb/features/ads_manager/domain/entities/ads_manager_entity.dart';

sealed class AdsManagerEvent extends Equatable {
  const AdsManagerEvent();
}

final class AdsManagerEventUpdated extends AdsManagerEvent {
  final AdsManagerEntity adsManager;

  const AdsManagerEventUpdated(this.adsManager);

  @override
  List<Object?> get props => [adsManager];
}

final class AdsManagerEventIncrement extends AdsManagerEvent {
  const AdsManagerEventIncrement();

  @override
  List<Object?> get props => [];
}

final class AdsManagerEventReset extends AdsManagerEvent {
  const AdsManagerEventReset();

  @override
  List<Object?> get props => [];
}
