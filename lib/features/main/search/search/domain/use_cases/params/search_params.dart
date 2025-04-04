import 'package:equatable/equatable.dart';

final class SearchParams extends Equatable {
  final String query;
  final int pageNo;

  SearchParams({required this.query, required this.pageNo});

  @override
  List<Object?> get props => [query, pageNo];
}
