import 'package:dio/dio.dart';
import 'package:tmdb/core/api/api_exception_messages.dart';

class ApiException implements Exception {
  final String message;

  ApiException(this.message);

  factory ApiException.fromError(dynamic error) {
    String errorMsg = ApiExceptionMessages.unknown;
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
          errorMsg = ApiExceptionMessages.connectionTimeout;
          break;
        case DioExceptionType.sendTimeout:
          errorMsg = ApiExceptionMessages.sendTimeout;
          break;
        case DioExceptionType.receiveTimeout:
          errorMsg = ApiExceptionMessages.receiveTimeout;
          break;
        case DioExceptionType.badCertificate:
          errorMsg = ApiExceptionMessages.badCertificate;
          break;
        case DioExceptionType.badResponse:
          errorMsg = ApiExceptionMessages.badResponse;
          switch (error.response?.statusCode) {
            case 400:
              errorMsg = ApiExceptionMessages.badRequest;
              break;
            case 401:
              errorMsg = ApiExceptionMessages.unauthorized;
              break;
            case 403:
              errorMsg = ApiExceptionMessages.forbidden;
              break;
            case 404:
              errorMsg = ApiExceptionMessages.notFound;
              break;
            case 500:
              errorMsg = ApiExceptionMessages.internalServerError;
              break;
            case 503:
              errorMsg = ApiExceptionMessages.serviceUnavailable;
              break;
          }
          break;
        case DioExceptionType.cancel:
          errorMsg = ApiExceptionMessages.cancel;
          break;
        case DioExceptionType.connectionError:
          errorMsg = ApiExceptionMessages.connectionError;
          break;
        case DioExceptionType.unknown:
          errorMsg = ApiExceptionMessages.unknown;
          break;
      }
    }
    return ApiException(errorMsg);
  }
}
