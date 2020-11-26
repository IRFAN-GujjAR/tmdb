import 'package:flutter/material.dart';

class WatchListMediaState {
  const WatchListMediaState();
}

class WatchListMediaLoading extends WatchListMediaState {}

class WatchListMediaAdded extends WatchListMediaState {
  final int mediaId;

  const WatchListMediaAdded({@required this.mediaId});
}

class WatchListMediaRemoved extends WatchListMediaState {
  final int mediaId;

  const WatchListMediaRemoved({@required this.mediaId});
}

class WatchListMediaError extends WatchListMediaState {
  final dynamic error;

  const WatchListMediaError({@required this.error});
}
