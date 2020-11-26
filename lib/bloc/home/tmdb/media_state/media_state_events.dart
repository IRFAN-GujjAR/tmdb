import 'package:flutter/material.dart';

class MediaStateEvent {
  const MediaStateEvent();
}

class LoadMediaState extends MediaStateEvent {
  final String url;

  const LoadMediaState({@required this.url});
}
