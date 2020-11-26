import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:tmdb/models/user_info_model.dart';
import 'package:tmdb/network/api_provider.dart';
import 'package:tmdb/repositories/base_repo.dart';
import 'package:tmdb/utils/urls.dart';
import 'package:tmdb/utils/utils.dart';

class RateMediaRepo extends BaseRepo {
  final MediaType _mediaType;

  RateMediaRepo({@required Client client, @required MediaType mediaType})
      : _mediaType = mediaType,
        super(client);

  final _headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
  };

  Future<void> rateMedia(
      {@required UserInfoModel user,
      @required int rating,
      @required int mediaId}) async {
    final body = '{"value":$rating}';
    try {
      final json = await ApiProvider.post(
          httpClient: client,
          url: URLS.mediaRate(
              user: user, mediaType: _mediaType, mediaId: mediaId),
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

  Future<void> deleteMediaRating(
      {@required UserInfoModel user, @required int mediaId}) async {
    try {
      final json = await ApiProvider.delete(
          client: client,
          url: URLS.mediaRate(
              user: user, mediaType: _mediaType, mediaId: mediaId),
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
