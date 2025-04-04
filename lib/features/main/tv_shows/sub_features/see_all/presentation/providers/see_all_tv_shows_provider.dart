import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tmdb/core/firebase/cloud_functions/cloud_functions_json_keys.dart';
import 'package:tmdb/features/main/tv_shows/sub_features/see_all/presentation/pages/extra/see_all_tv_shows_page_extra.dart';

import '../../../../../../../core/entities/tv_show/tv_shows_list_entity.dart';
import '../../../../../../../core/ui/scroll_controller_util.dart';
import '../../domain/use_cases/params/see_all_tv_shows_params.dart';
import '../blocs/see_all_tv_shows_bloc.dart';

final class SeeAllTvShowsProvider extends ChangeNotifier {
  final SeeAllTvShowsBloc _tvShowsBloc;
  late StreamSubscription _streamSubscription;
  TvShowsListEntity _tvShowsList;
  final String _pageTitle;
  String get pageTitle => _pageTitle;

  late ScrollControllerUtil _scrollControllerUtil;
  ScrollController get scrollController =>
      _scrollControllerUtil.scrollController;
  bool _isScrollControllerUtlParam = false;
  late Map<String, dynamic> _cfParams;

  SeeAllTvShowsProvider({
    required SeeAllTvShowsBloc seeAllTvShowsBloc,
    required SeeAllTvShowsPageExtra extra,
    ScrollControllerUtil? scrollControllerUtl,
  }) : _tvShowsBloc = seeAllTvShowsBloc,
       _pageTitle = extra.pageTitle,
       _tvShowsList = extra.tvShowsList,
       _cfParams = extra.cfParams {
    _scrollControllerUtil = scrollControllerUtl ?? ScrollControllerUtil();
    _isScrollControllerUtlParam = scrollControllerUtl != null;
    _scrollControllerUtil.addScrollListenerForLoadMore(() {
      _onLoad;
    });
    _streamSubscription = seeAllTvShowsBloc.stream.listen((state) {
      _onStateChange(state);
    });
  }

  TvShowsListEntity get tvShowsList => _tvShowsList;

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  bool _isError = false;
  bool get isError => _isError;
  String _errorMsg = "";
  String get errorMsg => _errorMsg;

  void get _onLoad {
    if (!_isLoading && tvShowsList.pageNo < tvShowsList.totalPages) {
      final cfParams = _cfParams;
      cfParams[CFJsonKeys.PARAMS_DATA][CFJsonKeys.PAGE_NO] =
          tvShowsList.pageNo + 1;
      _tvShowsBloc.add(
        SeeAllTvShowsEventLoad(params: SeeAllTvShowsParams(cfParams: cfParams)),
      );
    }
  }

  void _onStateChange(SeeAllTvShowsState state) {
    switch (state) {
      case SeeAllTvShowsStateInitial():
        break;
      case SeeAllTvShowsStateLoading():
        _onLoading;
        break;
      case SeeAllTvShowsStateLoaded():
        _onLoaded(state.tvShowsList);
        break;
      case SeeAllTvShowsStateError():
        _onError(state.error.error.errorMessage);
        break;
    }
  }

  void get _onLoading {
    _isLoading = true;
    _isError = false;
  }

  void _onLoaded(TvShowsListEntity tvShowsList) {
    final newTvShowsList = TvShowsListEntity(
      pageNo: tvShowsList.pageNo,
      totalPages: tvShowsList.totalPages,
      tvShows: _tvShowsList.tvShows + tvShowsList.tvShows,
    );
    _tvShowsList = newTvShowsList;
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
    _tvShowsBloc.close();
    if (!_isScrollControllerUtlParam) _scrollControllerUtil.dispose();
    super.dispose();
  }
}
