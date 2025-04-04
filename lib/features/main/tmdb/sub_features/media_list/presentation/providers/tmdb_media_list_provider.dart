import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb/core/firebase/cloud_functions/categories/sort_by_cf_category.dart';
import 'package:tmdb/features/main/tmdb/sub_features/media_list/data/function_params/tmdb_media_list_cf_params_data.dart';

import '../blocs/tmdb_media_list_bloc.dart';
import '../blocs/tmdb_media_list_event.dart';

final class TMDbMediaListProvider extends ChangeNotifier {
  TMDbMediaListCfParamsData paramsData;

  TMDbMediaListProvider({required this.paramsData}) {
    _sortBy = paramsData.sortBy;
  }

  SortByCFCategory _sortBy = SortByCFCategory.desc;
  SortByCFCategory get sortBy => _sortBy;

  void setSortBy(BuildContext context, SortByCFCategory value) {
    _sortBy = value;
    paramsData = paramsData.updateSortBy(_sortBy);
    context.read<TMDbMediaListBloc>().add(TMDbMediaListEventLoad(paramsData));
    notifyListeners();
  }
}
