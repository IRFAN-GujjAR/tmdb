import 'dart:async';

import 'package:firebase_app_check/firebase_app_check.dart';

abstract class CustomFirebaseExceptionsUtils {
  static const userDisabled = 'user-disabled';
  static const tooManyRequests = 'too-many-requests';
  static const networkRequestFailed = 'network-request-failed';
  static const unavailable = 'unavailable';
  static const unexpectedErrorMsg =
      'An unexcepcted error has occurred. Please try again later.';

  String? getErrorMsg(dynamic e) {
    if (e is TimeoutException) {
      return 'Please check your internet connection';
    } else if (e is FirebaseException) {
      switch (e.code) {
        case tooManyRequests:
          return 'You have made too many requests. Please try again later.';
        case networkRequestFailed:
        case unavailable:
          return 'Please check your internet connection';
        case userDisabled:
          return 'You are blocked from accessing TMDb App. You have violated our terms and conditions.';
        default:
          return null;
      }
    }
    return null;
  }

  CustomFirebaseExceptionType? getExceptionType(dynamic e) {
    if (e is TimeoutException) {
      return CustomFirebaseExceptionType.timeout;
    } else if (e is FirebaseException) {
      switch (e.code) {
        case tooManyRequests:
          return CustomFirebaseExceptionType.tooManyRequests;
        case networkRequestFailed:
        case unavailable:
          return CustomFirebaseExceptionType.networkRequestFailed;
        case userDisabled:
          return CustomFirebaseExceptionType.userDisabled;
        default:
          return null;
      }
    }
    return null;
  }
}

enum CustomFirebaseExceptionType {
  timeout,
  networkRequestFailed,
  tooManyRequests,
  userDisabled,
  unexpected,
}
