import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tmdb/bottom_navigation/tmdb/favourite/favourite.dart';
import 'package:tmdb/bottom_navigation/tmdb/ratings/rating.dart';
import 'package:tmdb/bottom_navigation/tmdb/watchlist/watchlist.dart';
import 'package:tmdb/login.dart';
import 'package:tmdb/main.dart';
import 'package:tmdb/provider/login_info_provider.dart';
import 'package:tmdb/provider/movie_provider.dart';
import 'package:tmdb/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TMDb extends StatefulWidget {

  TMDb({Key key}) : super(key: key);

  _TMDbState createState() => _TMDbState();
}

class _TMDbState extends State<TMDb> {
  String _sessionId = '';
  String _userId = '';
  String _username = '';
  bool _isLoading = true;
  bool _isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    _loadAccountDetails();
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  _loadAccountDetails() async {
    if (_sessionId != null && _sessionId.isNotEmpty) {
      setState(() {
        _isLoggedIn = true;
      });
    }
    setState(() {
      _isLoading = false;
    });
  }


  void _navigateToRating(BuildContext context) {
    if (_isLoggedIn) {
      Navigator.of(context).push(isIOS
          ? CupertinoPageRoute(
              builder: (context) => Rating(
                    username: _username,
                    sessionId: _sessionId,
                    accountId: _userId,
                  ))
          : MaterialPageRoute(
              builder: (context) => Rating(
                    username: _username,
                    sessionId: _sessionId,
                    accountId: _userId,
                  )));
    } else {
      showUserIsNotLoggedIn(context);
    }
  }

  void _navigateToWatchList(BuildContext context) {
    if (_isLoggedIn) {
      Navigator.of(context).push(isIOS
          ? CupertinoPageRoute(
              builder: (context) => WatchList(
                    username: _username,
                    sessionId: _sessionId,
                    accountId: _userId,
                  ))
          : MaterialPageRoute(
              builder: (context) => WatchList(
                    username: _username,
                    sessionId: _sessionId,
                    accountId: _userId,
                  )));
    } else {
      showUserIsNotLoggedIn(context);
    }
  }

  void _navigateToFavourite(BuildContext context) {
    if (_isLoggedIn) {
      Navigator.of(context).push(isIOS
          ? CupertinoPageRoute(
              builder: (context) => Favourite(
                    username: _username,
                    sessionId: _sessionId,
                    accountId: _userId,
                  ))
          : MaterialPageRoute(
              builder: (context) => Favourite(
                    username: _username,
                    sessionId: _sessionId,
                    accountId: _userId,
                  )));
    } else {
      showUserIsNotLoggedIn(context);
    }
  }

  Widget get _buildBodyItemsAndroid {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Column(
        children: <Widget>[
          !_isLoggedIn
              ? Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: RaisedButton(
                    padding: const EdgeInsets.all(20),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    color: Colors.black,
                    onPressed: () {
                      _navigateToLogin();
                    },
                    child: Text(
                      'Sign in / Create account',
                      style: TextStyle(fontSize: 18, color: Colors.blue),
                    ),
                  ),
                )
              : Container(),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: RaisedButton(
              onPressed: () => _navigateToFavourite(context),
              color: Colors.black,
              child: ListTile(
                contentPadding: const EdgeInsets.all(0),
                leading: Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Icon(
                    Icons.favorite_border,
                    size: 28,
                  ),
                ),
                title: Text('Favourite'),
                subtitle: Text('Your favourite Moives and Tvshows'),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: RaisedButton(
              onPressed: () {
                _navigateToWatchList(context);
              },
              color: Colors.black,
              child: ListTile(
                contentPadding: const EdgeInsets.all(0),
                leading: Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Icon(
                    Icons.bookmark_border,
                    size: 28,
                  ),
                ),
                title: Text('WatchList'),
                subtitle: Text('Movies and TvShows Added to watchlist'),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: RaisedButton(
              onPressed: () {
                _navigateToRating(context);
              },
              color: Colors.black,
              child: ListTile(
                contentPadding: const EdgeInsets.all(0),
                leading: Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Icon(
                    Icons.star_border,
                    size: 30,
                  ),
                ),
                title: Text('Ratings'),
                subtitle: Text('Rated Movies and TvShows'),
              ),
            ),
          ),
//          Padding(
//            padding: const EdgeInsets.only(top:8.0),
//            child: RaisedButton(
//              onPressed: () {
//                _navigateToTMDbList(context);
//              },
//              color: Colors.black,
//              child: ListTile(
//                contentPadding: const EdgeInsets.all(0),
//                leading: Padding(
//                  padding: const EdgeInsets.only(top: 4.0),
//                  child: Icon(
//                    Icons.list,
//                    size: 30,
//                  ),
//                ),
//                title: Text('List'),
//                subtitle: Text('Your created lists'),
//              ),
//            ),
//          ),
        ],
      ),
    );
  }

  Widget get _buildItemsForIOS {
    return Material(
      color: Colors.black,
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Column(
          children: <Widget>[
            !_isLoggedIn
                ? Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: CupertinoButton(
                      padding: const EdgeInsets.all(20),
                      onPressed: () {
                        _navigateToLogin();
                      },
                      child: Text(
                        'Sign in / Create account',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.blue),
                      ),
                    ),
                  )
                : Container(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CupertinoButton(
                onPressed: () => _navigateToFavourite(context),
                padding: const EdgeInsets.only(left: 20),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(0),
                  leading: Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Icon(
                      Icons.favorite_border,
                      size: 28,
                      color: Colors.white,
                    ),
                  ),
                  title: Text(
                    'Favourite',
                    style: TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    'Your favourite Moives and Tvshows',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CupertinoButton(
                onPressed: () {
                  _navigateToWatchList(context);
                },
                padding: const EdgeInsets.only(left: 20),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(0),
                  leading: Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Icon(
                      Icons.bookmark_border,
                      size: 28,
                      color: Colors.white,
                    ),
                  ),
                  title: Text(
                    'WatchList',
                    style: TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    'Movies and TvShows Added to watchlist',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CupertinoButton(
                onPressed: () {
                  _navigateToRating(context);
                },
                padding: const EdgeInsets.only(left: 20),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(0),
                  leading: Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Icon(
                      Icons.star_border,
                      size: 28,
                      color: Colors.white,
                    ),
                  ),
                  title: Text(
                    'Ratings',
                    style: TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    'Rated Movies and TvShows',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
            ),
//            Padding(
//              padding: const EdgeInsets.all(8.0),
//              child: CupertinoButton(
//                onPressed: () {
//                  _navigateToTMDbList(context);
//                },
//                padding: const EdgeInsets.only(left: 20),
//                child: ListTile(
//                  contentPadding: const EdgeInsets.all(0),
//                  leading: Padding(
//                    padding: const EdgeInsets.only(top: 4.0),
//                    child: Icon(
//                      Icons.list,
//                      size: 28,
//                      color: Colors.white,
//                    ),
//                  ),
//                  title: Text(
//                    'Lists',
//                    style: TextStyle(color: Colors.white),
//                  ),
//                  subtitle: Text(
//                    'Your created lists',
//                    style: TextStyle(color: Colors.grey),
//                  ),
//                ),
//              ),
//            ),
          ],
        ),
      ),
    );
  }

  void _signOut() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(SESSION_ID, '');
    await sharedPreferences.setString(USER_ID, '');
    await sharedPreferences.setString(USER_NAME, '');
    await sharedPreferences.setBool(IS_APP_STARTED_FIRST_TIME, false);
    _loginInfoProvider.signOut();
    _movieTvShowProvider.userSignedOut();
  }

  void _navigateToLogin() {
    Navigator.push(
        context,
        isIOS
            ? CupertinoPageRoute(
                builder: (context) => Login(
                      navigationCategory: NavigationCategory.BackWard,
                    ))
            : MaterialPageRoute(
                builder: (context) => Login(
                      navigationCategory: NavigationCategory.BackWard,
                    )));
  }

  Widget get _buildBody {
    var topPadding = MediaQuery.of(context).padding.top;

    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(top: topPadding + 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              children: <Widget>[
                SizedBox(
                  width: 10,
                ),
                Icon(
                  Icons.account_circle,
                  size: 40,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  _isLoggedIn ? _username : 'Your Account',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 28),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            isIOS ? _buildItemsForIOS : _buildBodyItemsAndroid,
            SizedBox(
              height: 20,
            ),
            _isLoggedIn
                ? isIOS
                    ? CupertinoButton(
                        onPressed: () {
                          _signOut();
                        },
                        color: Colors.black,
                        child: Text(
                          'Sign out',
                          style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.w500,
                              fontSize: 17),
                        ),
                      )
                    : RaisedButton(
                        onPressed: () {
                          _signOut();
                        },
                        padding: const EdgeInsets.only(
                            left: 35, right: 35, top: 15, bottom: 15),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        color: Colors.black,
                        child: Text(
                          'Sign out',
                          style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.w500,
                              fontSize: 18),
                        ),
                      )
                : Container()
          ],
        ),
      ),
    );
  }

  LoginInfoProvider _loginInfoProvider;
  MovieTvShowProvider _movieTvShowProvider;

  @override
  Widget build(BuildContext context) {
    _loginInfoProvider = Provider.of<LoginInfoProvider>(context);
    _isLoggedIn = _loginInfoProvider.isSignedIn;
    if (_isLoggedIn) {
      _sessionId = _loginInfoProvider.sessionId;
      _userId = _loginInfoProvider.accountId;
      _username = _loginInfoProvider.username;
    }
    _movieTvShowProvider = Provider.of<MovieTvShowProvider>(context);

    return isIOS
        ? _isLoading
            ? CupertinoActivityIndicator()
            : CupertinoPageScaffold(child: _buildBody)
        : _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Scaffold(
                body: _buildBody,
              );
  }
}
