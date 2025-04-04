import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tmdb/core/models/celebs/celebrities_list_model.dart';
import 'package:tmdb/core/models/movie/movies_list_model.dart';
import 'package:tmdb/core/models/tv_show/tv_shows_list_model.dart';

import '../../../../../../core/firebase/cloud_functions/cloud_functions_json_keys.dart';

part 'search_details_model.g.dart';

@JsonSerializable(createToJson: false, ignoreUnannotated: true)
final class SearchDetailsModel extends Equatable {
  @JsonKey(name: CFJsonKeys.MOVIES)
  final MoviesListModel moviesList;
  @JsonKey(name: CFJsonKeys.TV_SHOWS)
  final TvShowsListModel tvShowsList;
  @JsonKey(name: CFJsonKeys.CELEBS)
  final CelebritiesListModel celebritiesList;

  SearchDetailsModel({
    required this.moviesList,
    required this.tvShowsList,
    required this.celebritiesList,
  });

  factory SearchDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$SearchDetailsModelFromJson(json);

  @override
  List<Object?> get props => [moviesList, tvShowsList, celebritiesList];
}
