
class TMDbListData{
  final int id;
  final String name;
  final int favoriteCount;
  final int itemCount;
  final String listType;
  final String iso_639_1;


  TMDbListData({this.id,this.name,this.favoriteCount,this.itemCount,this.listType,this.iso_639_1});

  factory TMDbListData.fromJson(Map<String,dynamic> json){
    return TMDbListData(
      id: json['id'],
      name: json['name'],
      favoriteCount: json['favorite_count'],
      itemCount: json['item_count'],
      listType: json['list_type'],
      iso_639_1: json['iso_639_1']
    );
  }
}
