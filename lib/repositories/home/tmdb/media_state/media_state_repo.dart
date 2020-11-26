import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:tmdb/models/media_state_model.dart';
import 'package:tmdb/network/api_provider.dart';
import 'package:tmdb/repositories/base_repo.dart';

class MediaStateRepo extends BaseRepo {
  MediaStateRepo({@required Client client}) : super(client);

  Future<MediaStateModel> checkMediaStates(String url) async {
    try {
      final json = await ApiProvider.get(url: url, httpClient: client);
      return MediaStateModel.fromJson(json);
    } catch (error) {
      throw error;
    }
  }
}
