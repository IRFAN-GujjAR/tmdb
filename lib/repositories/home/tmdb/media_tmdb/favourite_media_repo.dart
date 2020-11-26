import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:tmdb/models/user_info_model.dart';
import 'package:tmdb/network/api_provider.dart';
import 'package:tmdb/repositories/base_repo.dart';
import 'package:tmdb/utils/urls.dart';
import 'package:tmdb/utils/utils.dart';

class FavouriteMediaRepo extends BaseRepo {
  final MediaType _mediaType;

  FavouriteMediaRepo({@required Client client, @required MediaType mediaType})
      : _mediaType = mediaType,
        super(client);

  Future<void> markorUnMarkFavourite(
      {@required UserInfoModel user,
      @required bool mark,
      @required int mediaId}) async {
    final headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };
    final body =
        '{ "media_type": "${MEDIA_TYPE_VALUE[_mediaType]}","media_id": $mediaId,"favorite": $mark}';
    try {
      final json = await ApiProvider.post(
          httpClient: client,
          url: URLS.mediaFavourite(user),
          stringBody: body,
          headers: headers);
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
