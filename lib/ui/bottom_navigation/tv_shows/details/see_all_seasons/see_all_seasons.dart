import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tmdb/main.dart';
import 'package:tmdb/models/details/tv_show_details_data.dart';
import 'package:tmdb/ui/bottom_navigation/tv_shows/season/season_details.dart';

class SeeAllSeasons extends StatefulWidget {
  final String previousPageTitle;
  final int tvShowId;
  final String episodeImagePlaceHolder;
  final List<Season> seasons;

  SeeAllSeasons(
      {this.previousPageTitle,
      this.tvShowId,
      this.episodeImagePlaceHolder,
      this.seasons});

  @override
  _SeeAllSeasonsState createState() => _SeeAllSeasonsState();
}

class _SeeAllSeasonsState extends State<SeeAllSeasons> {
  final String imageBaseUrl = 'https://image.tmdb.org/t/p/w92';

  void _navigateToSeasonDetails(Season season) {
    Navigator.push(
        context,
        isIOS
            ? CupertinoPageRoute(
                builder: (context) => SeasonDetails(
                      id: widget.tvShowId,
                      name: season.name,
                      previousPageTitle: 'Seasons',
                      seasonNumber: season.seasonNumber,
                      episodeImagePlaceHolder: widget.episodeImagePlaceHolder,
                    ))
            : MaterialPageRoute(
                builder: (context) => SeasonDetails(
                      id: widget.tvShowId,
                      name: season.name,
                      previousPageTitle: 'Seasons',
                      seasonNumber: season.seasonNumber,
                      episodeImagePlaceHolder: widget.episodeImagePlaceHolder,
                    )));
  }

  Widget get _buildSeeAllSeasonsWidget {
    final padding = MediaQuery.of(context).padding;
    final topPadding = padding.top + kToolbarHeight;
    final bottomPadding = padding.bottom;

    return ListView.separated(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: isIOS
            ? EdgeInsets.only(
                top: topPadding, left: 10, bottom: bottomPadding + 20)
            : const EdgeInsets.only(left: 10, bottom: 20, top: 20),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => _navigateToSeasonDetails(widget.seasons[index]),
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(width: 0, style: BorderStyle.none)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                      height: 85,
                      width: 63,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 0.5),
                      ),
                      child: Image.network(
                          imageBaseUrl + widget.seasons[index].posterPath,
                          fit: BoxFit.fill)),
                  Container(
                    width: 250,
                    padding: const EdgeInsets.only(top: 4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            '${widget.seasons[index].name}',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
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
                  )
                ],
              ),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return Divider(
            height: 20,
            thickness: 0.2,
            color: Colors.grey,
          );
        },
        itemCount: widget.seasons.length);
  }

  @override
  Widget build(BuildContext context) {
    return isIOS
        ? CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              previousPageTitle: 'Back',
              middle: Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Text(
                  widget.previousPageTitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            child: _buildSeeAllSeasonsWidget,
          )
        : Scaffold(
            appBar: AppBar(
              title: Text(widget.previousPageTitle),
            ),
            body: _buildSeeAllSeasonsWidget,
          );
  }
}
