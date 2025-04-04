final class ApiExceptionMessages {
  static const String connectionTimeout =
      'Connection timeout! Please check your internet connection.';
  static const String sendTimeout =
      'Send timeout! Please check your internet connection.';
  static const String receiveTimeout =
      'Receive timeout! Please check your internet connection.';
  static const String badCertificate =
      'Bad certificate! Please check your internet connection.';
  static const String badResponse =
      'Bad response! Please check your internet connection.';
  static const String cancel =
      'Request cancelled! Please check your internet connection.';
  static const String connectionError =
      'Connection error! Please check your internet connection.';
  static const String unknown = 'Unknown error! Please try again later.';

  //Bad Response subtypes
  static const String badRequest = 'Bad request! Please check your input.';
  static const String unauthorized =
      'Unauthorized! Please check your credentials.';
  static const String forbidden =
      'Forbidden! You do not have permission to access this resource.';
  static const String notFound =
      'Not found! The requested resource could not be found.';
  static const String internalServerError =
      'Internal server error! Please try again later.';
  static const String serviceUnavailable =
      'Service unavailable! Please try again later.';

  static const String serverError =
      'Oops! Our servers are having trouble. If this keeps happening, try again later.';
}
