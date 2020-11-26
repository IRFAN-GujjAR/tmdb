import 'package:flutter/material.dart';

class RateMediaState {
  const RateMediaState();
}

class RateMediaLoading extends RateMediaState {}

class RateMediaRated extends RateMediaState {
  final int mediaId;

  const RateMediaRated({@required this.mediaId});
}

class RateMediaUnRated extends RateMediaState {
  final int mediaId;

  const RateMediaUnRated({@required this.mediaId});
}

class RateMediaError extends RateMediaState {
  final dynamic error;

  const RateMediaError({@required this.error});
}
