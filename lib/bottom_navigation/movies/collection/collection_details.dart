import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tmdb/bottom_navigation/common/rating/common_widgets.dart';
import 'package:tmdb/bottom_navigation/movies/details/movie_details.dart';
import 'package:tmdb/main.dart';
import 'package:tmdb/models/details/collection_details_data.dart';
import 'package:tmdb/models/movies_data.dart';
import 'package:tmdb/network/collection_details_api.dart';
import 'package:tmdb/utils/utils.dart';

class CollectionDetails extends StatefulWidget {
  final int id;
  final String name;
  final String previousPageTitle;

  CollectionDetails(
      {@required this.id,
      @required this.name,
      @required this.previousPageTitle});

  @override
  _CollectionDetailsState createState() => _CollectionDetailsState();
}

class _CollectionDetailsState extends State<CollectionDetails> {
  CollectionDetailsData _collectionDetailsData;
  bool _isDataLoaded = false;
  bool _isInternet = true;
  StreamSubscription<ConnectivityResult> _subscription;

  @override
  void initState() {
    super.initState();
    _subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result != ConnectivityResult.none && !_isInternet) {
        _initializeCollectionDetails();
      }
    });
    _initializeCollectionDetails();
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _subscription.cancel();
  }

  void _initializeCollectionDetails() async {
    setState(() {
      _isDataLoaded = false;
    });
    _collectionDetailsData =
        await getCollectionDetails(http.Client(), widget.id);
    if (_collectionDetailsData == null) {
      setState(() {
        _isInternet = false;
      });
    } else {
      setState(() {
        _isInternet = true;
      });
    }
    setState(() {
      _isDataLoaded = true;
    });
  }

  Widget _buildRatingWidget(double voteAverage, int voteCount) {
    List<IconData> stars;

    double rating = voteAverage / 2;
    int counter = rating.toInt();

    for (int i = 0; i < counter; i++) {
      stars == null ? stars = [Icons.star] : stars.add(Icons.star);
    }

    if (rating.toString().contains('.')) {
      if (voteCount == 0 && voteAverage == 0) {
        stars = [Icons.star_border];
      } else {
        stars == null ? stars = [Icons.star_half] : stars.add(Icons.star_half);
      }
    }
    while (stars.length < 5) {
      stars.add(Icons.star_border);
    }

    return Container(
      margin: const EdgeInsets.only(top: 25),
      height: 15,
      width: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return index != 5
              ? Icon(
                  stars[index],
                  color: Colors.blue,
                  size: 12,
                )
              : Padding(
                  padding: const EdgeInsets.only(left: 5, top: 2),
                  child: Text(
                    '( $voteCount )',
                    style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue),
                  ));
        },
        itemCount: 6,
      ),
    );
  }

  Widget get _divider {
    return Container(
      margin: const EdgeInsets.only(top: 15.0),
      height: isIOS ? 0.5 : 0,
      color: Colors.grey[900],
    );
  }

  Widget _buildCollectionItems(List<MoviesData> movies) {
    int counter = 0;

    List<Widget> items = movies.map((movie) {
      counter++;
      return GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              isIOS
                  ? CupertinoPageRoute(builder: (context) {
                      return MovieDetails(
                        id: movie.id,
                        movieTitle: movie.title,
                        previousPageTitle: widget.name,
                      );
                    })
                  : MaterialPageRoute(builder: (context) {
                      return MovieDetails(
                        id: movie.id,
                        movieTitle: movie.title,
                        previousPageTitle: widget.name,
                      );
                    }));
        },
        child: Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(top: 15),
              decoration: BoxDecoration(
                  border: Border.all(width: 0, style: BorderStyle.none)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: 93,
                    width: 62,
                    decoration: BoxDecoration(
                        border: Border.all(width: 0.3, color: Colors.grey)),
                    child: Image.network(
                        IMAGE_BASE_URL + PosterSizes.w185 + movie.posterPath),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 3),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: 250,
                          child: Text(
                            counter.toString() + '. ' + movie.title,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                          width: 240,
                          margin: const EdgeInsets.only(top: 3),
                          child: Text(
                            getMovieGenres(movie.genreIds),
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        _buildRatingWidget(movie.voteAverage, movie.voteCount)
                      ],
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0, top: 25),
                    child: Icon(
                      CupertinoIcons.forward,
                      color: Colors.grey,
                      size: 18,
                    ),
                  )
                ],
              ),
            ),
            counter != movies.length
                ? Container(
                    margin: const EdgeInsets.only(top: 10),
                    height: 0.5,
                    color: Colors.grey[900],
                  )
                : Container(),
          ],
        ),
      );
    }).toList();

    items = [
          _divider,
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Text(
              'This Collection includedes',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
        ] +
        items;

    return Padding(
      padding: const EdgeInsets.only(left: 15.0),
      child:
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: items),
    );
  }

  Widget _buildCollectionDetailsWidget(
      CollectionDetailsData collectionDetails) {

    var padding=MediaQuery.of(context).padding;
    var topPadding=padding.top+kToolbarHeight;
    var bottomPadding=padding.bottom;

    return SingleChildScrollView(
      padding: isIOS
          ? EdgeInsets.only(bottom: bottomPadding+20,top: topPadding)
          : const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Stack(
            children: <Widget>[
              Padding(
                padding: isIOS
                    ? const EdgeInsets.only(top: 0)
                    : const EdgeInsets.only(top: 10),
                child: Container(
                    width: double.infinity,
                    height: 211,
                    child: Image.network(
                      IMAGE_BASE_URL +
                          BackDropSizes.w780 +
                          collectionDetails.backdropPath,
                      fit: BoxFit.fitWidth,
                    )),
              ),
              Padding(
                padding: isIOS
                    ? const EdgeInsets.only(top: 55.0)
                    : const EdgeInsets.only(top: 65),
                child: Container(
                  width: double.infinity,
                  height: 158,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.transparent, Colors.black],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: [0.0, 0.8])),
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: isIOS
                      ? const EdgeInsets.only(right: 5, top: 140.0)
                      : const EdgeInsets.only(right: 5, top: 155),
                  child: Container(
                      width: 92,
                      height: 136,
                      child: Image.network(
                        IMAGE_BASE_URL +
                            PosterSizes.w185 +
                            collectionDetails.posterPath,
                        fit: BoxFit.fitWidth,
                      )),
                ),
              ),
              Container(
                width: 250,
                margin: isIOS
                    ? const EdgeInsets.only(left: 15, top: 140)
                    : const EdgeInsets.only(left: 15, top: 155),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      collectionDetails.name,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 3.0),
                      child: Text(
                        collectionDetails.overview,
                        style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey,
                            fontWeight: FontWeight.w500),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          _buildCollectionItems(collectionDetails.movies)
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return isIOS
        ? CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              previousPageTitle: widget.previousPageTitle,
              middle: Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Text(
                  widget.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            child: _isDataLoaded
                ? _isInternet
                    ? _buildCollectionDetailsWidget(_collectionDetailsData)
                    : InternetConnectionErrorWidget(
                        onPressed: _initializeCollectionDetails,
                      )
                : Center(
                    child: CupertinoActivityIndicator(),
                  ))
        : Scaffold(
            appBar: AppBar(
              title: Text(widget.name),
            ),
            body: _isDataLoaded
                ? _isInternet
                    ? _buildCollectionDetailsWidget(_collectionDetailsData)
                    : InternetConnectionErrorWidget(
                        onPressed: _initializeCollectionDetails,
                      )
                : Center(
                    child: CircularProgressIndicator(),
                  ));
  }
}
