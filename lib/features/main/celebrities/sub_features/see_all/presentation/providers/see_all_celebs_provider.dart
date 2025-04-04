import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tmdb/core/entities/celebs/celebrities_list_entity.dart';
import 'package:tmdb/core/firebase/cloud_functions/cloud_functions_json_keys.dart';
import 'package:tmdb/core/ui/scroll_controller_util.dart';
import 'package:tmdb/features/main/celebrities/sub_features/see_all/presentation/blocs/see_all_celebs_bloc.dart';
import 'package:tmdb/features/main/celebrities/sub_features/see_all/presentation/pages/extra/see_all_celebs_page_extra.dart';

final class SeeAllCelebsProvider extends ChangeNotifier {
  final SeeAllCelebsBloc _seeAllBloc;
  late StreamSubscription _streamSubscription;
  CelebritiesListEntity _celebsList;
  final String _pageTitle;
  String get pageTitle => _pageTitle;

  final _scrollControllerUtil = ScrollControllerUtil();
  ScrollController get scrollController =>
      _scrollControllerUtil.scrollController;
  late Map<String, dynamic> _cfParams;

  SeeAllCelebsProvider({
    required SeeAllCelebsBloc seeAllCelebsBloc,
    required SeeAllCelebsPageExtra extra,
  }) : _seeAllBloc = seeAllCelebsBloc,
       _pageTitle = extra.pageTitle,
       _celebsList = extra.celebsList,
       _cfParams = extra.cfParams {
    _scrollControllerUtil.addScrollListenerForLoadMore(() {
      _onLoad;
    });
    _streamSubscription = _seeAllBloc.stream.listen((state) {
      _onStateChange(state);
    });
  }

  CelebritiesListEntity get celebsList => _celebsList;

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  bool _isError = false;
  bool get isError => _isError;
  String _errorMsg = "";
  String get errorMsg => _errorMsg;

  void get _onLoad {
    if (!_isLoading && celebsList.pageNo < celebsList.totalPages) {
      final cfParams = _cfParams;
      cfParams[CFJsonKeys.PARAMS_DATA][CFJsonKeys.PAGE_NO] =
          celebsList.pageNo + 1;
      _seeAllBloc.add(SeeAllCelebsEventLoad(cfParams));
    }
  }

  void _onStateChange(SeeAllCelebsState state) {
    switch (state) {
      case SeeAllCelebsStateInitial():
        break;
      case SeeAllCelebsStateLoading():
        _onLoading;
        break;
      case SeeAllCelebsStateLoaded():
        _onLoaded(state.celebritiesList);
        break;
      case SeeAllCelebsStateError():
        _onError(errorMsg);
        break;
    }
  }

  void get _onLoading {
    _isLoading = true;
    _isError = false;
  }

  void _onLoaded(CelebritiesListEntity celebsList) {
    final newMoviesList = CelebritiesListEntity(
      pageNo: celebsList.pageNo,
      totalPages: celebsList.totalPages,
      celebrities: _celebsList.celebrities + celebsList.celebrities,
    );
    _celebsList = newMoviesList;
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
    _seeAllBloc.close();
    _scrollControllerUtil.dispose();
    super.dispose();
  }
}
