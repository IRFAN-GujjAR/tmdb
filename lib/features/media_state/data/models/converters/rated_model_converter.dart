import 'package:tmdb/features/media_state/data/models/rated_model.dart';

final class RatedModelConverter {
  /// Converts from JSON to a `Rated` object.
  static RatedModel fromJson(dynamic json) {
    if (json is bool) {
      return RatedModel(value: 0);
    } else {
      return RatedModel.fromJson(json);
    }
  }
}
