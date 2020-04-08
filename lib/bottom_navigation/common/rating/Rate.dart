import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tmdb/main.dart';
import 'package:tmdb/provider/login_info_provider.dart';
import 'package:tmdb/network/tmdb_account/tmdb_account_api.dart';
import 'package:tmdb/provider/movie_provider.dart';
import 'package:tmdb/utils/utils.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

enum RatingCategory { Movie, TvShow }

class Rate extends StatefulWidget {
  final int mediaId;
  final String titleOrName;
  final String posterPath;
  final String backdropPath;
  final int rating;
  final RatingCategory ratingCategory;

  Rate(
      {
      @required this.mediaId,
      @required this.titleOrName,
      @required this.posterPath,
      @required this.backdropPath,
      @required this.rating,
      @required this.ratingCategory});

  @override
  _RateState createState() => _RateState();
}

class _RateState extends State<Rate> {
  bool _isLoading = false;
  int _rating = 0;
  bool _isRated = false;
  MovieTvShowProvider _movieTvShowProvider;
  String _sessionId = '';
  bool _isSignedIn = false;

  @override
  void initState() {
    super.initState();
    _rating = widget.rating;
    _isRated = _rating != 0 ? true : false;
  }

  void _rateMedia() async {
    setState(() {
      _isLoading = true;
    });
    bool isRatedSuccessfully = await rateMovie(http.Client(),
        _sessionId, widget.mediaId, _rating.toDouble(), widget.ratingCategory);
    setState(() {
      _isLoading = false;
    });
    _isRated = isRatedSuccessfully;
    if (_isRated) {
      MediaTMDbData mediaTMDbData =
          widget.ratingCategory == RatingCategory.Movie
              ? _movieTvShowProvider.getMovieTMDbData(widget.mediaId)
              : _movieTvShowProvider.getTvShowTMDbData(widget.mediaId);
      if (mediaTMDbData != null) {
        MediaTMDbData mediaTMDbData2 = MediaTMDbData(
            id: widget.mediaId,
            isAddedToFavorite: mediaTMDbData.isAddedToFavorite,
            isRated: isRatedSuccessfully,
            rating: _rating,
            isAddedToWatchList: mediaTMDbData.isAddedToWatchList);
        widget.ratingCategory == RatingCategory.Movie
            ? _movieTvShowProvider.addMovie(mediaTMDbData2)
            : _movieTvShowProvider.addTvShow(mediaTMDbData2);
      } else {
        MediaTMDbData mediaTMDbData2 = MediaTMDbData(
            id: widget.mediaId,
            isAddedToFavorite: false,
            isRated: isRatedSuccessfully,
            rating: _rating,
            isAddedToWatchList: false);
        widget.ratingCategory == RatingCategory.Movie
            ? _movieTvShowProvider.addMovie(mediaTMDbData2)
            : _movieTvShowProvider.addTvShow(mediaTMDbData2);
      }
      Navigator.pop(context);
    }
  }

  Future<bool> _showAlertDialog() async {
    bool yes = false;

    isIOS
        ? await showCupertinoDialog(
            context: context,
            builder: (context) {
              return CupertinoAlertDialog(
                content: Text('Are you sure you want to delete the rating ? '),
                actions: <Widget>[
                  CupertinoButton(
                    child: Text('Yes'),
                    onPressed: () {
                      yes = true;
                      Navigator.pop(context);
                    },
                  ),
                  CupertinoButton(
                    child: Text('No'),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              );
            })
        : await showDialog(
            context: context,
            barrierDismissible: true,
            builder: (context) {
              return AlertDialog(
                backgroundColor: Colors.grey[900],
                content: Text('Are you sure you want to delete the rating ? '),
                actions: <Widget>[
                  FlatButton(
                    child: Text('Cancel'),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  FlatButton(
                    child: Text('Yes'),
                    onPressed: () {
                      yes = true;
                      Navigator.pop(context);
                    },
                  ),
                ],
              );
            });

    return yes;
  }

  void _deleteRating() async {
    bool deleteRatingCheck = false;
    deleteRatingCheck = await _showAlertDialog();

    bool isRatingDeletedSuccessfully = false;

    if (deleteRatingCheck) {
      setState(() {
        _isLoading = true;
      });

      isRatingDeletedSuccessfully = await deleteRating(
          http.Client(),
          _sessionId,
          widget.mediaId,
          _rating.toDouble(),
          widget.ratingCategory);
      setState(() {
        _isLoading = false;
      });
      if (isRatingDeletedSuccessfully != null && isRatingDeletedSuccessfully) {
        MediaTMDbData mediaTMDbData =
            widget.ratingCategory == RatingCategory.Movie
                ? _movieTvShowProvider.getMovieTMDbData(widget.mediaId)
                : _movieTvShowProvider.getTvShowTMDbData(widget.mediaId);
        MediaTMDbData mediaTMDbData2 = MediaTMDbData(
            id: widget.mediaId,
            isAddedToFavorite: mediaTMDbData.isAddedToFavorite,
            isRated: false,
            rating: 0,
            isAddedToWatchList: mediaTMDbData.isAddedToWatchList);
        widget.ratingCategory == RatingCategory.Movie
            ? _movieTvShowProvider.addMovie(mediaTMDbData2)
            : _movieTvShowProvider.addTvShow(mediaTMDbData2);
        Navigator.pop(context);
      } else {
        showInternetConnectionFailureError(context);
      }
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
            IMAGE_BASE_URL + PosterSizes.w500 + widget.posterPath,
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
        Padding(
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
              _rating == 0 || _rating != 0
                  ? Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Text(
                        '$_rating',
                        style: TextStyle(
                            fontSize: 28, fontWeight: FontWeight.w500),
                      ),
                    )
                  : Container(),
              _buildRatingWidget,
              isIOS
                  ? CupertinoButton(
                      onPressed: _rating == 0 || _isLoading || !_isSignedIn
                          ? null
                          : () {
                              _rateMedia();
                            },
                      color: Colors.blue,
                      child: Text('Rate'),
                    )
                  : RaisedButton(
                      onPressed: _rating == 0 || _isLoading || !_isSignedIn
                          ? null
                          : () {
                              _rateMedia();
                            },
                      child: Text('Rate'),
                    ),
              SizedBox(
                height: isIOS ? 20 : 10,
              ),
              _isRated
                  ? isIOS
                      ? CupertinoButton(
                          onPressed: _rating == 0 || _isLoading || !_isSignedIn
                              ? null
                              : () {
                                  _deleteRating();
                                },
                          padding: const EdgeInsets.only(left: 30, right: 30),
                          color: Colors.red,
                          child: Text(
                            'Remove rating',
                            style: TextStyle(),
                          ),
                        )
                      : RaisedButton(
                          onPressed: _rating == 0 || _isLoading || !_isSignedIn
                              ? null
                              : () {
                                  _deleteRating();
                                },
                          color: Colors.red,
                          child: Text('Delete Rating'),
                        )
                  : Container()
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    LoginInfoProvider loginInfoProvider =
        Provider.of<LoginInfoProvider>(context);
    _sessionId = loginInfoProvider.sessionId;
    _isSignedIn = loginInfoProvider.isSignedIn;

    _movieTvShowProvider = Provider.of<MovieTvShowProvider>(context);
    return isIOS
        ? CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(),
            child: _buildRatingBody,
          )
        : Scaffold(appBar: AppBar(), body: _buildRatingBody);
  }
}
