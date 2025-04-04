import 'package:equatable/equatable.dart';

final class SeeAllMoviesParams extends Equatable {
  final Map<String, dynamic> cfParams;

  SeeAllMoviesParams({required this.cfParams});

  @override
  List<Object?> get props => [cfParams];
}
