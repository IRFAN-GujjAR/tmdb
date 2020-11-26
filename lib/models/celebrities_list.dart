import 'celebrities_data.dart';

class CelebritiesList {
  final int pageNumber;
  final int totalPages;
  final List<CelebritiesData> celebrities;

  CelebritiesList({this.pageNumber, this.totalPages, this.celebrities});

  factory CelebritiesList.fromJson(Map<String, dynamic> json) =>
      CelebritiesList(
          pageNumber: json['page'],
          totalPages: json['total_pages'],
          celebrities: json['results']
              .map<CelebritiesData>((json) => CelebritiesData.fromJson(json))
              .toList());
}
