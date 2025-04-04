import 'package:equatable/equatable.dart';

final class SearchEntity extends Equatable {
  final String searchTitle;
  SearchEntity({required this.searchTitle});

  @override
  List<Object?> get props => [searchTitle];
}
