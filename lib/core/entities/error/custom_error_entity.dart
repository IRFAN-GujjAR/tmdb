import 'package:tmdb/core/error/custom_error_types.dart';
import 'package:tmdb/core/error/error_entity.dart';

final class CustomErrorEntity {
  final CustomErrorTypes type;
  final ErrorEntity error;

  CustomErrorEntity({required this.type, required this.error});
}
