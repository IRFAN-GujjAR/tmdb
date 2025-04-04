import 'package:tmdb/features/media_state/data/function_params/media_state_cf_params_data.dart';

sealed class MediaStateEvent {
  const MediaStateEvent();
}

final class MediaStateEventLoad extends MediaStateEvent {
  final MediaStateCFParamsData cfParamsData;

  MediaStateEventLoad(this.cfParamsData);
}
