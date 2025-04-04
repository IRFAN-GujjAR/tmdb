import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../../../../core/firebase/cloud_functions/cloud_functions_json_keys.dart';
import '../../../../../../../core/models/movie/movies_list_model.dart';
import '../../../../../../../core/models/tv_show/tv_shows_list_model.dart';

part 'tmdb_media_list_model.g.dart';

@JsonSerializable(createToJson: false, ignoreUnannotated: false)
final class TMDbMediaListModel extends Equatable {
  @JsonKey(name: CFJsonKeys.MOVIES)
  final MoviesListModel moviesList;
  @JsonKey(name: CFJsonKeys.TV_SHOWS)
  final TvShowsListModel tvShowsList;

  const TMDbMediaListModel({
    required this.moviesList,
    required this.tvShowsList,
  });

  factory TMDbMediaListModel.fromJson(Map<String, dynamic> json) =>
      _$TMDbMediaListModelFromJson(json);

  @override
  List<Object?> get props => [moviesList, tvShowsList];
}
