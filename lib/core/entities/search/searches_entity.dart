import 'package:equatable/equatable.dart';
import 'package:tmdb/core/entities/search/search_entity.dart';

class SearchesEntity extends Equatable {
  final List<SearchEntity> searches;

  SearchesEntity({required this.searches});

  @override
  List<Object?> get props => [searches];
}
