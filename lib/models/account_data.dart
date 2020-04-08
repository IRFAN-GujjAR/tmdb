

class AccountData{

  final int id;
  final String name;
  final String username;

  AccountData({this.id,this.name,this.username});

  factory AccountData.fromJson(Map<String,dynamic> json){
    return AccountData(
      id: json['id'],
      name: json['name'],
      username: json['username']
    );
  }
}