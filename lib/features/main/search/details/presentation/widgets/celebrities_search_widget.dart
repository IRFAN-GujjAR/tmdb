import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tmdb/core/firebase/cloud_functions/categories/search/search_cf_category.dart';
import 'package:tmdb/core/firebase/cloud_functions/categories/search/search_list_cf_category.dart';
import 'package:tmdb/core/firebase/cloud_functions/cloud_functions_utl.dart';
import 'package:tmdb/features/main/search/details/data/function_params/search_list_cf_params.dart';
import 'package:tmdb/features/main/search/details/data/function_params/search_list_cf_params_data.dart';

import '../../../../../../core/entities/celebs/celebrities_list_entity.dart';
import '../../../../../ads_manager/presentation/blocs/ads_manager_bloc.dart';
import '../../../../celebrities/sub_features/see_all/data/data_sources/see_all_celebs_data_source.dart';
import '../../../../celebrities/sub_features/see_all/data/repositories/see_all_celebs_repo_impl.dart';
import '../../../../celebrities/sub_features/see_all/domain/use_cases/see_all_celebs_use_case.dart';
import '../../../../celebrities/sub_features/see_all/presentation/blocs/see_all_celebs_bloc.dart';
import '../../../../celebrities/sub_features/see_all/presentation/pages/extra/see_all_celebs_page_extra.dart';
import '../../../../celebrities/sub_features/see_all/presentation/providers/see_all_celebs_provider.dart';
import '../../../../celebrities/sub_features/see_all/presentation/widgets/see_all_celebs_widget.dart';
import '../providers/search_details_provider.dart';

class CelebritiesSearchWidget extends StatefulWidget {
  final CelebritiesListEntity celebritiesList;
  const CelebritiesSearchWidget({super.key, required this.celebritiesList});

  @override
  State<CelebritiesSearchWidget> createState() =>
      _CelebritiesSearchWidgetState();
}

class _CelebritiesSearchWidgetState extends State<CelebritiesSearchWidget>
    with AutomaticKeepAliveClientMixin<CelebritiesSearchWidget> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ChangeNotifierProvider(
      create:
          (_) => SeeAllCelebsProvider(
            seeAllCelebsBloc: SeeAllCelebsBloc(
              context.read<AdsManagerBloc>(),
              SeeAllCelebsUseCase(
                SeeAllCelebsRepoImpl(
                  SeeAllCelebsDataSourceImpl(CloudFunctionsUtl.searchFunction),
                ),
              ),
            ),
            extra: SeeAllCelebsPageExtra(
              pageTitle: 'Celebrities',
              celebsList: widget.celebritiesList,
              cfParams:
                  SearchListCFParams(
                    category: SearchCFCategory.list,
                    data: SearchListCFParamsData(
                      listCategory: SearchListCFCategory.person,
                      query: context.read<SearchDetailsProvider>().query,
                      pageNo: 1,
                    ),
                  ).toJson(),
            ),
          ),
      child: SeeAllCelebsWidget(),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
