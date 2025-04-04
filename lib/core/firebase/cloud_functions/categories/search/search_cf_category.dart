import 'package:json_annotation/json_annotation.dart';

enum SearchCFCategory {
  trending,
  @JsonValue('multi_search')
  multiSearch,
  details,
  list,
}
