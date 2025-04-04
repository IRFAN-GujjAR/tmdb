import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tmdb/core/entities/movie/movies_list_entity.dart';
import 'package:tmdb/core/firebase/cloud_functions/cloud_functions_json_keys.dart';

import '../../../../../../../core/ui/scroll_controller_util.dart';
import '../../domain/use_cases/params/see_all_movies_params.dart';
import '../blocs/see_all_movies_bloc.dart';
import '../pages/extra/see_all_movies_page_extra.dart';

final class SeeAllMoviesProvider extends ChangeNotifier {
  final SeeAllMoviesBloc _seeAllMoviesBloc;
  late StreamSubscription _streamSubscription;
  MoviesListEntity _moviesList;
  final String _pageTitle;
  String get pageTitle => _pageTitle;

  late ScrollControllerUtil _scrollControllerUtil;
  ScrollController get scrollController =>
      _scrollControllerUtil.scrollController;
  bool _isScrollControllerUtlParam = false;
  late Map<String, dynamic> _cfParams;

  SeeAllMoviesProvider({
    required SeeAllMoviesBloc seeAllMoviesBloc,
    required SeeAllMoviesPageExtra extra,
    ScrollControllerUtil? scrollControllerUtl,
  }) : _seeAllMoviesBloc = seeAllMoviesBloc,
       _pageTitle = extra.pageTitle,
       _moviesList = extra.moviesList,
       _cfParams = extra.cfParams {
    _scrollControllerUtil = scrollControllerUtl ?? ScrollControllerUtil();
    _isScrollControllerUtlParam = scrollControllerUtl != null;
    _scrollControllerUtil.addScrollListenerForLoadMore(() {
      _onLoad;
    });
    _streamSubscription = _seeAllMoviesBloc.stream.listen((state) {
      _onStateChange(state);
    });
  }

  MoviesListEntity get moviesList => _moviesList;

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  bool _isError = false;
  bool get isError => _isError;
  String _errorMsg = "";
  String get errorMsg => _errorMsg;

  void get _onLoad {
    if (!_isLoading) {
      final cfParams = _cfParams;
      cfParams[CFJsonKeys.PARAMS_DATA][CFJsonKeys.PAGE_NO] =
          moviesList.pageNo + 1;
      _seeAllMoviesBloc.add(
        SeeAllMoviesEventLoad(params: SeeAllMoviesParams(cfParams: cfParams)),
      );
    }
  }

  void _onStateChange(SeeAllMoviesState state) {
    switch (state) {
      case SeeAllMoviesStateInitial():
        break;
      case SeeAllMoviesStateLoading():
        _onLoading;
        break;
      case SeeAllMoviesStateLoaded():
        _onLoaded(state.moviesList);
        break;
      case SeeAllMoviesStateError():
        _onError(state.error.error.errorMessage);
        break;
    }
  }

  void get _onLoading {
    _isLoading = true;
    _isError = false;
  }

  void _onLoaded(MoviesListEntity moviesList) {
    final newMoviesList = MoviesListEntity(
      pageNo: moviesList.pageNo,
      totalPages: moviesList.totalPages,
      movies: _moviesList.movies + moviesList.movies,
    );
    _moviesList = newMoviesList;
    _isLoading = false;
    notifyListeners();
  }

  void _onError(String errorMsg) {
    _errorMsg = errorMsg;
    _isError = true;
    _isLoading = false;
  }

  @override
  void dispose() {
    _streamSubscription.cancel();
    _seeAllMoviesBloc.close();
    if (!_isScrollControllerUtlParam) _scrollControllerUtil.dispose();
    super.dispose();
  }
}
