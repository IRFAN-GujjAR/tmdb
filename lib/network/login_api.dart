import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:tmdb/utils/utils.dart';

Future<String> getSessionId(
    http.Client client, String username, String password) async {
  String token = await _createRequestToken(client);
  if (token == null) {
    return null;
  } else {
    String verifiedToken =
        await _verifyToken(client, token, username, password);
    if (verifiedToken == null) {
      return null;
    } else {
      String sessionId = await _createSessionId(client, verifiedToken);
      return sessionId;
    }
  }
}

Future<String> _createRequestToken(http.Client client) async {
  final String url =
      'https://api.themoviedb.org/3/authentication/token/new?api_key=$Api_Key';
  http.Response response;
  try {
    response = await client
        .get(url)
        .timeout(const Duration(seconds: TIME_OUT_DURATION));
  } on Exception {
    return null;
  }
  var body = json.decode(response.body);
  String token = body['request_token'];
  if(token==null){
    return '';
  }
  return token;
}

Future<String> _verifyToken(http.Client client, String token, String username,
    String password) async {
  String url =
      'https://api.themoviedb.org/3/authentication/token/validate_with_login?api_key=$Api_Key';
  String body =
      '{"username": "$username","password": "$password","request_token": "$token"}';
  Map<String, String> headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
  };
  http.Response response;
  try {
    response = await client
        .post(url, headers: headers, body: body)
        .timeout(const Duration(seconds: TIME_OUT_DURATION));
  } on Exception {
    return null;
  }

  String requestToken=json.decode(response.body)['request_token'];
  if(requestToken==null){
    return '';
  }
  return requestToken;
}

Future<String> _createSessionId(
    http.Client client, String verifiedToken) async {
  String url =
      'https://api.themoviedb.org/3/authentication/session/new?api_key=$Api_Key';
  Map<String, String> headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
  };
  String body = '{"request_token":"$verifiedToken"}';
  http.Response response;
  try {
    response = await client
        .post(url, headers: headers, body: body)
        .timeout(const Duration(seconds: TIME_OUT_DURATION));
  } on Exception{
    return null;
  }

  String sessionId=json.decode(response.body)['session_id'];
  if(sessionId==null){
    return '';
  }
  return sessionId;
}
