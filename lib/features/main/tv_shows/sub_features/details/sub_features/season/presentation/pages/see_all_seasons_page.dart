import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tmdb/core/router/routes/app_router_paths.dart';
import 'package:tmdb/core/ui/initialize_app.dart';
import 'package:tmdb/core/ui/screen_utils.dart';
import 'package:tmdb/core/ui/widgets/custom_body_widget.dart';
import 'package:tmdb/core/ui/widgets/divider_widget.dart';
import 'package:tmdb/features/main/tv_shows/sub_features/details/sub_features/season/presentation/pages/extra/see_all_seasons_page_extra.dart';
import 'package:tmdb/features/main/tv_shows/sub_features/details/sub_features/season/presentation/pages/extra/tv_show_season_details_page_extra.dart';

import '../../../../../../../../../core/ui/widgets/movie_poster_placeholder_widget.dart';

class SeeAllSeasonsPage extends StatelessWidget {
  final SeeAllSeasonsPageExtra _extra;

  SeeAllSeasonsPage(this._extra, {super.key});

  final String imageBaseUrl = 'https://image.tmdb.org/t/p/w92';

  Widget get _buildSeeAllSeasonsWidget {
    return ListView.separated(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.only(
        left: PagePadding.leftPadding,
        top: PagePadding.topPadding,
        bottom: PagePadding.bottomPadding,
      ),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            appRouterConfig.push(
              context,
              location: AppRouterPaths.TV_SHOW_SEASON_DETAILS_LOCATION,
              extra: TvShowSeasonDetailsPageExtra(
                tvId: _extra.tvId,
                tvShowName: _extra.tvShowName,
                seasonName: _extra.seasons[index].name,
                seasonNo: _extra.seasons[index].seasonNo,
                tvShowPosterPath: _extra.tvShowPosterPath,
                episodeImagePlaceHolder: _extra.episodeImagePlaceHolder,
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(width: 0, style: BorderStyle.none),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 85,
                  width: 63,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 0.5),
                  ),
                  child:
                      _extra.seasons[index].posterPath == null
                          ? MoviePosterPlaceHolderWidget(size: 48)
                          : Image.network(
                            imageBaseUrl + _extra.seasons[index].posterPath!,
                            fit: BoxFit.fill,
                          ),
                ),
                Container(
                  width: 250,
                  padding: const EdgeInsets.only(top: 4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          '${_extra.seasons[index].name}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(top: 30.0, right: 10),
                  child: Icon(
                    CupertinoIcons.forward,
                    color: Colors.grey,
                    size: 18,
                  ),
                ),
              ],
            ),
          ),
        );
      },
      separatorBuilder: (context, index) {
        return DividerWidget(height: 20, indent: 0);
      },
      itemCount: _extra.seasons.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_extra.tvShowName)),
      body: CustomBodyWidget(child: _buildSeeAllSeasonsWidget),
    );
  }
}
