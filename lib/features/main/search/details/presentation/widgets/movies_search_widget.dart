import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tmdb/core/entities/movie/movies_list_entity.dart';
import 'package:tmdb/core/firebase/cloud_functions/categories/search/search_cf_category.dart';
import 'package:tmdb/core/firebase/cloud_functions/categories/search/search_list_cf_category.dart';
import 'package:tmdb/core/firebase/cloud_functions/cloud_functions_utl.dart';
import 'package:tmdb/features/main/search/details/data/function_params/search_list_cf_params.dart';
import 'package:tmdb/features/main/search/details/data/function_params/search_list_cf_params_data.dart';

import '../../../../../ads_manager/presentation/blocs/ads_manager_bloc.dart';
import '../../../../movies/sub_features/see_all/data/data_sources/see_all_movies_data_source.dart';
import '../../../../movies/sub_features/see_all/data/repositories/see_all_movies_repo_impl.dart';
import '../../../../movies/sub_features/see_all/domain/use_cases/see_all_movies_use_case.dart';
import '../../../../movies/sub_features/see_all/presentation/blocs/see_all_movies_bloc.dart';
import '../../../../movies/sub_features/see_all/presentation/pages/extra/see_all_movies_page_extra.dart';
import '../../../../movies/sub_features/see_all/presentation/providers/see_all_movies_provider.dart';
import '../../../../movies/sub_features/see_all/presentation/widgets/see_all_movies_widget.dart';
import '../providers/search_details_provider.dart';

class MoviesSearchWidget extends StatefulWidget {
  final MoviesListEntity moviesList;

  const MoviesSearchWidget({super.key, required this.moviesList});

  @override
  State<MoviesSearchWidget> createState() => _MoviesSearchWidgetState();
}

class _MoviesSearchWidgetState extends State<MoviesSearchWidget>
    with AutomaticKeepAliveClientMixin<MoviesSearchWidget> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ChangeNotifierProvider(
      create:
          (context) => SeeAllMoviesProvider(
            seeAllMoviesBloc: SeeAllMoviesBloc(
              context.read<AdsManagerBloc>(),
              SeeAllMoviesUseCase(
                SeeAllMoviesRepoImpl(
                  SeeAllMoviesDataSourceImpl(CloudFunctionsUtl.searchFunction),
                ),
              ),
            ),
            extra: SeeAllMoviesPageExtra(
              pageTitle: 'Movies',
              moviesList: widget.moviesList,
              cfParams:
                  SearchListCFParams(
                    category: SearchCFCategory.list,
                    data: SearchListCFParamsData(
                      listCategory: SearchListCFCategory.movie,
                      query: context.read<SearchDetailsProvider>().query,
                      pageNo: 1,
                    ),
                  ).toJson(),
            ),
          ),
      child: SeeAllMoviesWidget(),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
