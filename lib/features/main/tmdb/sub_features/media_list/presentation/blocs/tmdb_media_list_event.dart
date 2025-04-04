import 'package:equatable/equatable.dart';
import 'package:tmdb/features/main/tmdb/sub_features/media_list/data/function_params/tmdb_media_list_cf_params_data.dart';

sealed class TMDbMediaListEvent extends Equatable {
  const TMDbMediaListEvent();
}

final class TMDbMediaListEventLoad extends TMDbMediaListEvent {
  final TMDbMediaListCfParamsData cfParamsData;

  const TMDbMediaListEventLoad(this.cfParamsData);

  @override
  List<Object?> get props => [cfParamsData];
}
