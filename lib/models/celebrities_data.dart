class CelebritiesData {
  final int id;
  final String name;
  final String knownFor;
  final String profilePath;

  CelebritiesData({this.id, this.name, this.knownFor, this.profilePath});


  factory CelebritiesData.fromJson(Map<String,dynamic> json){
    return CelebritiesData(
      id: json['id'] as int,
      name: json['name'] as String,
      knownFor: json['known_for_department'] as String,
      profilePath: json['profile_path'] as String
    );
  }

}
