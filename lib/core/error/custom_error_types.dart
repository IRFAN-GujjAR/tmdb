enum CustomErrorTypes { NetworkError, UnknownError, ServerError }

extension CustomErrorTypesExtension on CustomErrorTypes {
  bool get isNetworkError => this == CustomErrorTypes.NetworkError;
}
