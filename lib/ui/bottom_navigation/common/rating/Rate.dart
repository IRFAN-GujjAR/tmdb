import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tmdb/bloc/home/tmdb/media_state_changes/media_state_changes_bloc.dart';
import 'package:tmdb/bloc/home/tmdb/media_state_changes/media_state_changes_events.dart';
import 'package:tmdb/bloc/home/tmdb/media_tmdb/rate/rate_media_bloc.dart';
import 'package:tmdb/bloc/home/tmdb/media_tmdb/rate/rate_media_events.dart';
import 'package:tmdb/bloc/home/tmdb/media_tmdb/rate/rate_media_states.dart';
import 'package:tmdb/main.dart';
import 'package:tmdb/network/main_api.dart';
import 'package:tmdb/provider/login_info_provider.dart';
import 'package:tmdb/repositories/home/tmdb/media_tmdb/rate_media_repo.dart';
import 'package:tmdb/utils/dialogs/dialogs_utils.dart';
import 'package:tmdb/utils/utils.dart';

enum RatingCategory { Movie, TvShow }

class Rate extends StatefulWidget {
  final int mediaId;
  final String titleOrName;
  final String posterPath;
  final String backdropPath;
  final int rating;
  final bool isRated;
  final MediaType mediaType;

  Rate(
      {@required this.mediaId,
      @required this.titleOrName,
      @required this.posterPath,
      @required this.backdropPath,
      @required this.rating,
      @required this.isRated,
      @required this.mediaType});

  @override
  _RateState createState() => _RateState();
}

class _RateState extends State<Rate> {
  int _rating = 0;

  @override
  void initState() {
    _rating = widget.rating;
    super.initState();
  }

  void rate(BuildContext context) {
    final user = Provider.of<LoginInfoProvider>(context, listen: false).user;
    context.read<RateMediaBloc>().add(AddRatingRateMedia(
        user: user, mediaId: widget.mediaId, rating: _rating));
  }

  void deleteRating(BuildContext context) async {
    if (await DialogUtils.showAlertDialog(
        context, 'Are you sure you want to delete the rating ?')) {
      final user = Provider.of<LoginInfoProvider>(context, listen: false).user;
      context
          .read<RateMediaBloc>()
          .add(DeleteRatingRateMedia(user: user, mediaId: widget.mediaId));
    }
  }

  Widget get _buildRatingWidget {
    return Container(
      height: 60,
      alignment: Alignment.center,
      child: ListView.separated(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  _rating = index + 1;
                });
              },
              child: Icon(
                _rating <= index ? Icons.star_border : Icons.star,
                color: Colors.blue,
                size: 28,
              ),
            );
          },
          separatorBuilder: (context, index) {
            return SizedBox(
              width: 4,
            );
          },
          itemCount: 10),
    );
  }

  void get _onRatingChanged {
    context.read<MediaStateChangesBloc>().add(
        widget.mediaType == MediaType.Movie
            ? NotifyMovieMediaStateChanges(movieId: widget.mediaId)
            : NotifyTvShowMediaStateChanges(tvId: widget.mediaId));
    Navigator.pop(context);
  }

  Widget get _buildRatingBody {
    var topPadding = isIOS
        ? MediaQuery.of(context).padding.top + kToolbarHeight + 10
        : MediaQuery.of(context).padding.top;

    return Stack(
      children: <Widget>[
        Container(
          width: double.maxFinite,
          height: double.maxFinite,
          child: Image.network(
            IMAGE_BASE_URL + PosterSizes.w342 + widget.posterPath,
            fit: BoxFit.fitWidth,
          ),
        ),
        Positioned.fill(
            child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(
            color: Colors.black.withOpacity(0.8),
          ),
        )),
        BlocProvider(
          create: (_) => RateMediaBloc(
              rateMediaRepo: RateMediaRepo(
            client: getHttpClient(context),
            mediaType: widget.mediaType,
          )),
          child: BlocConsumer<RateMediaBloc, RateMediaState>(
            listener: (context, state) {
              if (state is RateMediaRated) {
                _onRatingChanged;
              } else if (state is RateMediaUnRated) {
                _onRatingChanged;
              } else if (state is RateMediaError) {
                DialogUtils.showMessageDialog(context, state.error.toString());
              }
            },
            builder: (context, state) {
              final enable = !(state is RateMediaLoading) && _rating > 0;
              return Padding(
                padding: EdgeInsets.only(top: topPadding + 10.0),
                child: Column(
                  children: <Widget>[
                    Container(
                      width: 150,
                      height: 225,
                      decoration:
                          BoxDecoration(border: Border.all(color: Colors.grey)),
                      child: Image.network(
                        IMAGE_BASE_URL + PosterSizes.w342 + widget.posterPath,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Text(
                        '$_rating',
                        style: TextStyle(
                            fontSize: 28, fontWeight: FontWeight.w500),
                      ),
                    ),
                    _buildRatingWidget,
                    isIOS
                        ? CupertinoButton(
                            onPressed: enable
                                ? () {
                                    rate(context);
                                  }
                                : null,
                            color: Colors.blue,
                            child: Text('Rate'),
                          )
                        : RaisedButton(
                            onPressed: enable
                                ? () {
                                    rate(context);
                                  }
                                : null,
                            child: Text('Rate'),
                          ),
                    SizedBox(
                      height: isIOS ? 20 : 10,
                    ),
                    widget.isRated
                        ? isIOS
                            ? CupertinoButton(
                                onPressed: enable
                                    ? () {
                                        deleteRating(context);
                                      }
                                    : null,
                                padding:
                                    const EdgeInsets.only(left: 30, right: 30),
                                color: Colors.red,
                                child: Text(
                                  'Remove rating',
                                  style: TextStyle(),
                                ),
                              )
                            : RaisedButton(
                                onPressed: enable
                                    ? () {
                                        deleteRating(context);
                                      }
                                    : null,
                                color: Colors.red,
                                child: Text('Delete Rating'),
                              )
                        : Container()
                  ],
                ),
              );
            },
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return isIOS
        ? CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(),
            child: _buildRatingBody,
          )
        : Scaffold(appBar: AppBar(), body: _buildRatingBody);
  }
}
