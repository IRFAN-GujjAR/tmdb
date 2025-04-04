import 'package:json_annotation/json_annotation.dart';
import 'package:tmdb/core/firebase/cloud_functions/categories/sort_by_cf_category.dart';
import 'package:tmdb/core/firebase/cloud_functions/categories/tmdb/tmdb_media_list_cf_category.dart';
import 'package:tmdb/core/firebase/cloud_functions/categories/tmdb/tmdb_media_list_type_cf_category.dart';
import 'package:tmdb/core/firebase/cloud_functions/cloud_functions_json_keys.dart';

part 'tmdb_media_list_cf_params_data.g.dart';

@JsonSerializable(createFactory: false)
final class TMDbMediaListCfParamsData {
  @JsonKey(name: CFJsonKeys.LIST_CATEGORY)
  final TMDbMediaListCFCategory listCategory;
  @JsonKey(name: CFJsonKeys.LIST_TYPE)
  final TMDbMediaListTypeCFCategory listType;
  @JsonKey(name: CFJsonKeys.USER_ID)
  final int userId;
  @JsonKey(name: CFJsonKeys.SESSION_ID)
  final String sessionId;
  @JsonKey(name: CFJsonKeys.PAGE_NO)
  final int pageNo;
  @JsonKey(name: CFJsonKeys.SORT_BY)
  final SortByCFCategory sortBy;

  const TMDbMediaListCfParamsData({
    required this.listCategory,
    required this.listType,
    required this.userId,
    required this.sessionId,
    required this.pageNo,
    required this.sortBy,
  });

  Map<String, dynamic> toJson() => _$TMDbMediaListCfParamsDataToJson(this);

  TMDbMediaListCfParamsData updateSortBy(SortByCFCategory sortBy) {
    return TMDbMediaListCfParamsData(
      listCategory: listCategory,
      listType: listType,
      userId: userId,
      sessionId: sessionId,
      pageNo: pageNo,
      sortBy: sortBy,
    );
  }

  TMDbMediaListCfParamsData get movieList {
    return TMDbMediaListCfParamsData(
      listCategory: listCategory,
      listType: TMDbMediaListTypeCFCategory.movie,
      userId: userId,
      sessionId: sessionId,
      pageNo: pageNo,
      sortBy: sortBy,
    );
  }

  TMDbMediaListCfParamsData get tvShowsList {
    return TMDbMediaListCfParamsData(
      listCategory: listCategory,
      listType: TMDbMediaListTypeCFCategory.tv,
      userId: userId,
      sessionId: sessionId,
      pageNo: pageNo,
      sortBy: sortBy,
    );
  }
}
