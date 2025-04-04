import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb/core/firebase/cloud_functions/categories/sort_by_cf_category.dart';
import 'package:tmdb/core/firebase/cloud_functions/categories/tmdb/tmdb_media_list_cf_category.dart';
import 'package:tmdb/core/firebase/cloud_functions/categories/tmdb/tmdb_media_list_type_cf_category.dart';
import 'package:tmdb/features/main/tmdb/sub_features/media_list/data/function_params/tmdb_media_list_cf_params_data.dart';
import 'package:tmdb/features/main/tmdb/sub_features/media_list/presentation/blocs/tmdb_media_list_bloc.dart';
import 'package:tmdb/features/main/tmdb/sub_features/media_list/presentation/blocs/tmdb_media_list_event.dart';
import 'package:tmdb/features/main/tmdb/sub_features/media_list/presentation/blocs/tmdb_media_list_state.dart';
import 'package:tmdb/features/main/tmdb/sub_features/media_list/presentation/providers/tmdb_media_list_scroll_controller_provider.dart';
import 'package:tmdb/features/main/tmdb/sub_features/media_list/presentation/widgets/tmdb_media_list_menu_action_button_widget.dart';
import 'package:tmdb/features/main/tmdb/sub_features/media_list/presentation/widgets/tmdb_media_list_movies_widget.dart';
import 'package:tmdb/features/main/tmdb/sub_features/media_list/presentation/widgets/tmdb_media_list_tv_shows_widget.dart';

import '../../../../../../../core/ui/widgets/custom_error_widget.dart';
import '../../../../../../../core/ui/widgets/loading_widget.dart';
import '../../../../../../app_startup/sub_features/user_session/presentation/providers/user_session_provider.dart';

class TMDbMediaListPage extends StatelessWidget {
  final TMDbMediaListCFCategory _listCategory;

  const TMDbMediaListPage(this._listCategory, {super.key});

  Widget get _emptyWidget {
    String msg = "";
    switch (_listCategory) {
      case TMDbMediaListCFCategory.favorites:
        msg = 'No Movie or Tv Show is added to favorites!';
        break;
      case TMDbMediaListCFCategory.ratings:
        msg = 'No Movie or Tv Show is rated!';
        break;
      case TMDbMediaListCFCategory.watchlist:
        msg = 'No Movie or Tv Show is added to watchlist';
        break;
    }
    return Center(child: Text(msg));
  }

  Widget _buildBodyWithoutTab(
    BuildContext context,
    bool isLoading,
    TMDbMediaListState state,
  ) {
    Widget body = LoadingWidget();
    switch (state) {
      case TMDbMediaListStateInitial():
      case TMDbMediaListStateLoading():
        body = LoadingWidget();
        break;
      case TMDbMediaListStateLoaded():
        body =
            state.tMDBMediaList.isMovies
                ? TMDbMediaListMoviesWidget(
                  listCFCategory: _listCategory,
                  tMDBMediaList: state.tMDBMediaList,
                )
                : TMDbMediaListTvShowsWidget(
                  listCFCategory: _listCategory,
                  tMDBMediaList: state.tMDBMediaList,
                );
        break;
      case TMDbMediaListStateEmpty():
        body = _emptyWidget;
        break;
      case TMDbMediaListStateError():
        final user = context.read<UserSessionProvider>().userSession;
        body = CustomErrorWidget(
          error: state.error,
          onPressed: () {
            context.read<TMDbMediaListBloc>().add(
              TMDbMediaListEventLoad(
                TMDbMediaListCfParamsData(
                  listCategory: _listCategory,
                  listType: TMDbMediaListTypeCFCategory.both,
                  userId: user.userId,
                  sessionId: user.sessionId,
                  pageNo: 1,
                  sortBy: SortByCFCategory.asc,
                ),
              ),
            );
          },
        );
        break;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(_listCategory.title),
        actions:
            state is TMDbMediaListStateLoaded
                ? <Widget>[const TMDbMediaListMenuActionButtonWidget()]
                : <Widget>[],
      ),
      body: body,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TMDbMediaListBloc, TMDbMediaListState>(
      builder: (context, state) {
        final isLoading =
            state is TMDbMediaListStateLoading ||
            state is TMDbMediaListStateInitial;
        if (state is TMDbMediaListStateLoaded) {
          if (state.tMDBMediaList.isBoth) {
            return DefaultTabController(
              length: 2,
              child: Scaffold(
                body: NestedScrollView(
                  controller:
                      context
                          .read<TMDbMediaListScrollControllerProvider>()
                          .parentScrollController,
                  physics: ScrollPhysics(parent: PageScrollPhysics()),
                  headerSliverBuilder: (context, isInnerBoxScrolled) {
                    return [
                      SliverAppBar(
                        title: Text(_listCategory.title),
                        pinned: true,
                        snap: true,
                        floating: true,
                        bottom: TabBar(
                          tabs: [Tab(text: 'Movies'), Tab(text: 'Tv Shows')],
                        ),
                        actions: [const TMDbMediaListMenuActionButtonWidget()],
                      ),
                    ];
                  },
                  body: TabBarView(
                    children: [
                      TMDbMediaListMoviesWidget(
                        listCFCategory: _listCategory,
                        tMDBMediaList: state.tMDBMediaList,
                      ),
                      TMDbMediaListTvShowsWidget(
                        listCFCategory: _listCategory,
                        tMDBMediaList: state.tMDBMediaList,
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        }
        return _buildBodyWithoutTab(context, isLoading, state);
      },
    );
  }
}
