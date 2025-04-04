import 'package:flutter/material.dart';
import 'package:tmdb/core/router/routes/app_router_paths.dart';
import 'package:tmdb/core/ui/initialize_app.dart';
import 'package:tmdb/core/ui/widgets/custom_image_widget.dart';
import 'package:tmdb/core/urls/urls.dart';
import 'package:tmdb/features/main/tv_shows/sub_features/details/sub_features/season/presentation/pages/extra/see_all_seasons_page_extra.dart';
import 'package:tmdb/features/main/tv_shows/sub_features/details/sub_features/season/presentation/pages/extra/tv_show_season_details_page_extra.dart';

import '../../../../../../../core/entities/tv_show/season/season_entity.dart';
import '../../../../../../../core/ui/utils.dart';
import '../../../../../../../core/ui/widgets/details/details_divider_widget.dart';
import '../../../../../../../core/ui/widgets/text_row_widget.dart';

final class TvShowDetailsSeasonWidget extends StatelessWidget {
  final int tvId;
  final String tvShowName;
  final String? tvShowPosterPath;
  final String? episodeImagePlaceHolder;
  final List<SeasonEntity> seasons;

  const TvShowDetailsSeasonWidget({
    super.key,
    required this.tvId,
    required this.tvShowName,
    required this.tvShowPosterPath,
    required this.episodeImagePlaceHolder,
    required this.seasons,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        DetailsDividerWidget(topPadding: 15),
        TextRowWidget(
          categoryName: 'Seasons',
          showSeeAllBtn: true,
          onPressed: () {
            appRouterConfig.push(
              context,
              location: AppRouterPaths.SEE_ALL_SEASONS_LOCATION,
              extra: SeeAllSeasonsPageExtra(
                tvId: tvId,
                tvShowName: tvShowName,
                tvShowPosterPath: tvShowPosterPath,
                episodeImagePlaceHolder: episodeImagePlaceHolder,
                seasons: seasons,
              ),
            );
          },
        ),
        Container(
          height: 165,
          child: ListView.separated(
            physics: const AlwaysScrollableScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              String? posterPath = seasons[index].posterPath;
              if (posterPath != null) {
                posterPath = URLS.posterImageUrl(
                  imageUrl: posterPath,
                  size: PosterSizes.w185,
                );
              }
              return GestureDetector(
                onTap: () {
                  appRouterConfig.push(
                    context,
                    location: AppRouterPaths.TV_SHOW_SEASON_DETAILS_LOCATION,
                    extra: TvShowSeasonDetailsPageExtra(
                      tvId: tvId,
                      tvShowName: tvShowName,
                      seasonName: seasons[index].name,
                      seasonNo: seasons[index].seasonNo,
                      tvShowPosterPath: tvShowPosterPath,
                      episodeImagePlaceHolder: episodeImagePlaceHolder,
                    ),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.only(left: 10),
                  height: 180,
                  width: 100,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      CustomNetworkImageWidget(
                        type: MediaImageType.TvShow,
                        imageUrl: posterPath,
                        width: 92.5,
                        height: 139,
                        fit: BoxFit.fill,
                        borderRadius: 0,
                        placeHolderSize: 72,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 6.0),
                        child: Text(
                          seasons[index].name,
                          style: TextStyle(fontSize: 13),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return SizedBox(width: 10);
            },
            itemCount: seasons.length,
          ),
        ),
      ],
    );
  }
}
