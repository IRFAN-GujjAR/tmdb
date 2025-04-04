import 'package:equatable/equatable.dart';
import 'package:tmdb/core/entities/celebs/celebrities_list_entity.dart';

final class CelebritiesEntity extends Equatable {
  final CelebritiesListEntity popular;
  final CelebritiesListEntity trending;

  CelebritiesEntity({required this.popular, required this.trending});

  @override
  List<Object?> get props => [popular, trending];
}
