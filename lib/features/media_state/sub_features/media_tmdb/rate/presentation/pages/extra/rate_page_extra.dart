import '../../../../../../../../core/ui/utils.dart';
import '../../../../../media_state_changes/presentation/blocs/media_state_changes_bloc.dart';

final class RatePageExtra {
  final int mediaId;
  final String titleOrName;
  final String? posterPath;
  final String? backdropPath;
  final int rating;
  final bool isRated;
  final MediaType mediaType;
  final MediaStateChangesBloc mediaStateChangesBloc;

  const RatePageExtra({
    required this.mediaId,
    required this.titleOrName,
    required this.posterPath,
    required this.backdropPath,
    required this.rating,
    required this.isRated,
    required this.mediaType,
    required this.mediaStateChangesBloc,
  });
}
