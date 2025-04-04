import 'package:equatable/equatable.dart';
import 'package:tmdb/features/ads_manager/domain/entities/ads_manager_entity.dart';

final class AdsManagerState extends Equatable {
  final AdsManagerEntity adsManager;

  const AdsManagerState(this.adsManager);

  @override
  List<Object?> get props => [adsManager];
}
