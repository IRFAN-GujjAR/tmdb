import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:tmdb/models/user_info_model.dart';
import 'package:tmdb/network/api_provider.dart';
import 'package:tmdb/repositories/base_repo.dart';
import 'package:tmdb/utils/urls.dart';
import 'package:tmdb/utils/utils.dart';

class WatchListMediaRepo extends BaseRepo {
  final MediaType _mediaType;

  WatchListMediaRepo({@required Client client, @required MediaType mediaType})
      : _mediaType = mediaType,
        super(client);

  final _headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
  };

  Future<void> addOrRemoveFromWatchList(
      {@required UserInfoModel user,
      @required int mediaId,
      @required bool add}) async {
    final body =
        '{ "media_type": "${MEDIA_TYPE_VALUE[_mediaType]}","media_id": $mediaId,"watchlist": $add}';
    try {
      final json = await ApiProvider.post(
          httpClient: client,
          url: URLS.mediaWatchList(user),
          stringBody: body,
          headers: _headers);
      final int statusCode = json['status_code'];
      switch (statusCode) {
        case 1:
        case 12:
        case 13:
          break;
        default:
          throw json['status_message'];
      }
    } catch (error) {
      throw error;
    }
  }
}
