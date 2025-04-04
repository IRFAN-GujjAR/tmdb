import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tmdb/core/entities/common/genre_entity.dart';
import 'package:tmdb/features/app_startup/sub_features/user_session/presentation/providers/user_session_provider.dart';

import '../../../../features/media_state/presentation/blocs/media_state_bloc.dart';
import '../../../../features/media_state/presentation/blocs/media_state_state.dart';
import '../../theme/colors/colors_utils.dart';
import '../rating_widget.dart';
import 'details_genres_widget.dart';

class DetailsMainInformationWidget extends StatelessWidget {
  final String title;
  final double voteAverage;
  final int voteCount;
  final List<GenreEntity> genres;
  final String? overview;

  const DetailsMainInformationWidget({
    super.key,
    required this.title,
    required this.voteAverage,
    required this.voteCount,
    required this.genres,
    required this.overview,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 100, top: 200, right: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 5.0),
            child: Text(
              title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
          ),
          Consumer<UserSessionProvider>(
            builder: (context, provider, _) {
              return BlocBuilder<MediaStateBloc, MediaStateState>(
                builder: (context, state) {
                  final mediaState = state;
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Expanded(
                        flex: 5,
                        child: CustomRatingWidget(
                          voteAverage: voteAverage,
                          voteCount: voteCount,
                        ),
                      ),
                      Expanded(
                        flex:
                            provider.isLoggedIn &&
                                    (mediaState is MediaStateStateLoaded) &&
                                    mediaState.mediaState.isRated
                                ? 2
                                : 2,
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.star, size: 14),
                            SizedBox(width: 4),
                            Text(
                              '${voteAverage.toStringAsFixed(1)}',
                              style: TextStyle(
                                color: ColorUtils.primaryColor(context),
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      provider.isLoggedIn && mediaState is MediaStateStateLoaded
                          ? mediaState.mediaState.isRated
                              ? Expanded(
                                flex: 2,
                                child: Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.star,
                                      size: 14,
                                      color: Colors.blue,
                                    ),
                                    SizedBox(width: 4),
                                    Text(
                                      '${mediaState.mediaState.rated.value}',
                                      style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                              : Container()
                          : Container(),
                    ],
                  );
                },
              );
            },
          ),
          if (genres.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 8),
              child: DetailsGenresWidget(genres: genres),
            ),
          if (overview != null && overview!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 8),
              child: Text(
                overview!,
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ),
        ],
      ),
    );
  }
}
