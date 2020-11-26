import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tmdb/bloc/login/login_state/login_state_bloc.dart';
import 'package:tmdb/bloc/login/login_state/login_state_events.dart';
import 'package:tmdb/main.dart';
import 'package:tmdb/provider/login_info_provider.dart';
import 'package:tmdb/ui/bottom_navigation/tmdb/favourite/favourite.dart';
import 'package:tmdb/ui/bottom_navigation/tmdb/ratings/rating.dart';
import 'package:tmdb/ui/bottom_navigation/tmdb/watchlist/watchlist.dart';
import 'package:tmdb/ui/login.dart';
import 'package:tmdb/utils/dialogs/dialogs_utils.dart';
import 'package:tmdb/utils/navigation/navigation_utils.dart';
import 'package:provider/provider.dart';

class TMDb extends StatefulWidget {
  TMDb({Key key}) : super(key: key);

  _TMDbState createState() => _TMDbState();
}

class _TMDbState extends State<TMDb> {
  void _navigateToRating() {
    if (Provider.of<LoginInfoProvider>(context, listen: false).isSignedIn) {
      NavigationUtils.navigate(
          context: context, page: Rating(), rootNavigator: true);
    } else {
      showUserIsNotLoggedIn();
    }
  }

  void _navigateToWatchList() {
    if (Provider.of<LoginInfoProvider>(context, listen: false).isSignedIn) {
      NavigationUtils.navigate(
          context: context, page: WatchList(), rootNavigator: true);
    } else {
      showUserIsNotLoggedIn();
    }
  }

  void _navigateToFavourite() {
    if (Provider.of<LoginInfoProvider>(context, listen: false).isSignedIn) {
      NavigationUtils.navigate(
          context: context, page: Favourite(), rootNavigator: true);
    } else {
      showUserIsNotLoggedIn();
    }
  }

  void showUserIsNotLoggedIn() {
    DialogUtils.showMessageDialog(context,
        'You are not signed in. Please sign into to your TMDb account');
  }

  Widget get _buildBodyItemsAndroid {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Column(
        children: <Widget>[

          Consumer<LoginInfoProvider>(
            builder: (context,loginInfoProvider,_)=>
            !loginInfoProvider.isSignedIn? Padding(
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
            ):Container()
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: RaisedButton(
              onPressed: () => _navigateToFavourite(),
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
                _navigateToWatchList();
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
                _navigateToRating();
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
            Consumer<LoginInfoProvider>(
              builder: (context, loginInfoProvider, _) =>
                  !loginInfoProvider.isSignedIn
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
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CupertinoButton(
                onPressed: () => _navigateToFavourite(),
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
                  _navigateToWatchList();
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
                  _navigateToRating();
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
          ],
        ),
      ),
    );
  }

  void _signOut() async {
    await Provider.of<LoginInfoProvider>(context, listen: false).signOut();
    context.read<LoginStateBloc>().add(LoginStateEvents.Logout);
  }

  void _navigateToLogin() {
    NavigationUtils.navigate(
        context: context,
        page: Login(navigationCategory: NavigationCategory.BackWard),
        rootNavigator: true);
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
                Consumer<LoginInfoProvider>(
                  builder: (context, loginInfoProvider, _) => Text(
                    loginInfoProvider.isSignedIn
                        ? loginInfoProvider.user.userName
                        : 'Your Account',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 28),
                  ),
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
            Consumer<LoginInfoProvider>(
                builder: (context, loginInfoProvider, _) =>
                    loginInfoProvider.isSignedIn
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
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8))),
                                color: Colors.black,
                                child: Text(
                                  'Sign out',
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18),
                                ),
                              )
                        : Container()),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return isIOS
        ? CupertinoPageScaffold(child: _buildBody)
        : Scaffold(
            body: _buildBody,
          );
  }
}
