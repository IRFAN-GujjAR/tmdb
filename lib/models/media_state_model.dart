import 'package:flutter/material.dart';

class MediaStateModel {
  final int id;
  final bool favorite;
  final bool rated;
  final double rating;
  final bool watchlist;

  MediaStateModel({
    @required this.id,
    @required this.favorite,
    @required this.rated,
    @required this.rating,
    @required this.watchlist,
  });

  factory MediaStateModel.fromJson(Map<String, dynamic> json) =>
      MediaStateModel(
        id: json["id"],
        favorite: json["favorite"],
        rated: json['rated'] is bool ? json['rated'] : true,
        rating: json['rated'] is bool ? 0 : json['rated']['value'],
        watchlist: json["watchlist"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "favorite": favorite,
        "rated": rated,
        "rating": rating,
        "watchlist": watchlist,
      };
}
