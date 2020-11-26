import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:tmdb/network/custom_exceptions.dart';
import 'package:tmdb/utils/utils.dart';

class ApiProvider {
  static Future<dynamic> get(
      {@required String url, @required http.Client httpClient}) async {
    var responseJson;
    try {
      final response = await httpClient
          .get(url)
          .timeout(Duration(seconds: TIME_OUT_DURATION));
      responseJson = _response(response);
    } on SocketException {
      throw InternetConnectionException('No Internet Connection');
    } on TimeoutException {
      throw InternetConnectionException('No Internet Connection');
    }
    return responseJson;
  }

  static Future<dynamic> post(
      {@required http.Client httpClient,
      @required String url,
      Map<String, dynamic> body,
      String stringBody,
      Map<String, String> headers}) async {
    var responseJson;
    try {
      http.Response response;
      if (headers != null) {
        response = response = await httpClient
            .post(url, headers: headers, body: stringBody ?? body)
            .timeout(Duration(seconds: TIME_OUT_DURATION));
      } else if (body != null) {
        response = await httpClient
            .post(url, body: stringBody ?? body)
            .timeout(Duration(seconds: TIME_OUT_DURATION));
      } else {
        response = await httpClient
            .post(url)
            .timeout(Duration(seconds: TIME_OUT_DURATION));
      }
      responseJson = _response(response);
    } on SocketException {
      throw InternetConnectionException();
    } on TimeoutException {
      throw InternetConnectionException();
    }
    return responseJson;
  }

  static Future<dynamic> delete(
      {@required http.Client client,
      @required String url,
      @required Map<String, String> headers}) async {
    var responseJson;
    try {
      final response = await client
          .delete(url, headers: headers)
          .timeout(Duration(seconds: TIME_OUT_DURATION));
      responseJson = _response(response);
    } on SocketException {
      throw InternetConnectionException();
    } on TimeoutException {
      throw InternetConnectionException();
    }
    return responseJson;
  }

  static dynamic _response(http.Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        var responseJson = json.decode(response.body.toString());
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
