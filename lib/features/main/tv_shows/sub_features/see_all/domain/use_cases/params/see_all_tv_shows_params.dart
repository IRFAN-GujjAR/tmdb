import 'package:equatable/equatable.dart';

final class SeeAllTvShowsParams extends Equatable {
  final Map<String, dynamic> cfParams;

  SeeAllTvShowsParams({required this.cfParams});

  @override
  List<Object?> get props => [cfParams];
}
