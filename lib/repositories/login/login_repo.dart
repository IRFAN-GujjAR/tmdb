import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:tmdb/models/account_data.dart';
import 'package:tmdb/models/user_info_model.dart';
import 'package:tmdb/network/api_provider.dart';
import 'package:tmdb/repositories/base_repo.dart';
import 'package:tmdb/utils/urls.dart';

class LoginRepo extends BaseRepo {
  LoginRepo({@required Client client}) : super(client);

  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
  };

  Future<UserInfoModel> login(String username, String password) async {
    try {
      final requestToken = await _createRequestToken;
      final verifiedToken =
          await _verifyToken(requestToken, username, password);
      final sessionId = await _createSessionId(verifiedToken);
      final accountDetails = await _getAccountDetails(sessionId);
      return UserInfoModel(
          userId: accountDetails.id,
          userName: accountDetails.username,
          sessionId: sessionId);
    } catch (error) {
      throw error;
    }
  }

  Future<String> get _createRequestToken async {
    final json = await ApiProvider.get(
        url: URLS.CREATE_REQUEST_TOKEN, httpClient: client);
    final requestToken = json['request_token'];
    return requestToken;
  }

  Future<String> _verifyToken(
      String token, String username, String password) async {
    String body =
        '{"username": "$username","password": "$password","request_token": "$token"}';
    final json = await ApiProvider.post(
        httpClient: client,
        url: URLS.VERIFY_REQUEST_TOKEN,
        headers: headers,
        stringBody: body);
    final verifiedToken = json['request_token'];
    return verifiedToken;
  }

  Future<String> _createSessionId(String verifiedToken) async {
    String body = '{"request_token":"$verifiedToken"}';
    final json = await ApiProvider.post(
        httpClient: client,
        url: URLS.CREATE_SESSION_ID,
        stringBody: body,
        headers: headers);
    final sessionId = json['session_id'];
    return sessionId;
  }

  Future<AccountData> _getAccountDetails(String sessionId) async {
    final json = await ApiProvider.get(
        url: URLS.accountDetails(sessionId), httpClient: client);
    return AccountData.fromJson(json);
  }
}
