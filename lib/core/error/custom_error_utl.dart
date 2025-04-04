import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:tmdb/core/api/api_exception_messages.dart';
import 'package:tmdb/core/entities/error/custom_error_entity.dart';
import 'package:tmdb/core/error/custom_error_types.dart';
import 'package:tmdb/core/error/error_entity.dart';

import '../firebase/cloud_functions/error/cf_error_type.dart';

final class CustomErrorUtl {
  static CustomErrorEntity getError(dynamic e) {
    if (e is FirebaseFunctionsException) {
      final codeType = CFErrorType.fromString(e.code);
      if (codeType != null) {
        if (codeType == CFErrorType.internal) {
          if (e.message == 'themoviedb_api_error') {
            final errorEntity = ErrorEntity.fromJson(e.details);
            return CustomErrorEntity(
              type: CustomErrorTypes.ServerError,
              error: errorEntity,
            );
          }
        } else if (codeType == CFErrorType.unavailable) {
          return CustomErrorEntity(
            type: CustomErrorTypes.NetworkError,
            error: ErrorEntity(
              errorMessage: ApiExceptionMessages.connectionError,
              httpCode: 0,
              tMDBCode: 0,
            ),
          );
        }
      }
    } else if (e is FirebaseException) {
      if (e.code == 'internal') {
        return CustomErrorEntity(
          type: CustomErrorTypes.NetworkError,
          error: ErrorEntity(
            errorMessage: ApiExceptionMessages.connectionError,
            httpCode: 0,
            tMDBCode: 0,
          ),
        );
      }
    }
    return CustomErrorEntity(
      type: CustomErrorTypes.UnknownError,
      error: ErrorEntity(
        errorMessage: ApiExceptionMessages.unknown,
        httpCode: 0,
        tMDBCode: 0,
      ),
    );
  }
}
