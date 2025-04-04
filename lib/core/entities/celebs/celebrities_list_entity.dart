import 'package:equatable/equatable.dart';

import 'celebrity_entity.dart';

class CelebritiesListEntity extends Equatable {
  final int pageNo;
  final int totalPages;
  final List<CelebrityEntity> celebrities;

  CelebritiesListEntity(
      {required this.pageNo,
      required this.totalPages,
      required this.celebrities});

  @override
  List<Object?> get props => [pageNo, totalPages, celebrities];
}
