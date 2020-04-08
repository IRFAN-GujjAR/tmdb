

import 'package:tmdb/models/tmdb_list_data.dart';

class TMDbList{

  final int pageNumber;
  final int totalPages;
  final List<TMDbListData> tmbLists;

  TMDbList({this.pageNumber,this.totalPages,this.tmbLists});
}