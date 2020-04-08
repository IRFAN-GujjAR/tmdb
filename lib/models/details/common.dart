
List<Genre> getGenres(List<dynamic> json) {
  if (json == null || json.isEmpty) {
    return null;
  }

  List<Genre> genres = json.map((genre) => Genre.fromJson(genre)).toList();
  return genres;
}

class Genre {
  final String name;

  Genre({this.name});

  factory Genre.fromJson(Map<String, dynamic> json) {
    return Genre(name: json['name'] as String);
  }
}

class Credits {
  final List<Cast> cast;
  final List<Crew> crew;

  Credits({this.cast, this.crew});

  factory Credits.fromJson(Map<String, dynamic> json) {
    var castList = json['cast'] as List;
    List<Cast> casts = castList.map((cast) => Cast.fromJson(cast)).toList();

    var crewList = json['crew'] as List;
    List<Crew> crews = crewList.map((crew) => Crew.fromJson(crew)).toList();

    List<Crew> correctedCrews = [];
    if(crews!=null&&crews.isNotEmpty) {
      for (int i = 0; i < crews.length; i++) {
        if (correctedCrews.isEmpty) {
          String job = crews[i].job!=null?crews[i].job:'';
          for (int j = i + 1; j < crews.length; j++) {
            if (crews[i].id == crews[j].id) {
              if (crews[j].job != null) {
                job += crews[j].job!=null?', ${crews[j].job}':'';
              }
            }
          }
          correctedCrews.add(Crew(
              id: crews[i].id,
              name: crews[i].name,
              job: job,
              department: crews[i].department,
              profilePath: crews[i].profilePath));
        } else {
          bool isSame = false;
          correctedCrews.forEach((crew) {
            if (crew.id == crews[i].id) {
              isSame = true;
            }
          });
          if (!isSame) {
            String job = crews[i].job!=null?crews[i].job:'';
            for (int j = i + 1; j < crews.length; j++) {
              if (crews[i].id == crews[j].id) {
                if (crews[j].job != null) {
                  job += crews[j].job!=null?', ${crews[j].job}':'';
                }
              }
            }
            correctedCrews.add(Crew(
                id: crews[i].id,
                name: crews[i].name,
                job: job,
                department: crews[i].department,
                profilePath: crews[i].profilePath));
          }
        }
      }
    }

    return Credits(cast: casts, crew: correctedCrews);
  }
}

class Cast {
  final int id;
  final String character;
  final String name;
  final int gender;
  final int order;
  final String profilePath;

  Cast(
      {this.id,
      this.character,
      this.name,
      this.gender,
      this.order,
      this.profilePath});

  factory Cast.fromJson(Map<String, dynamic> json) {
    return Cast(
        id: json['id'] as int,
        character: json['character'] as String,
        name: json['name'] as String,
        gender: json['gender'] as int,
        order: json['order'] as int,
        profilePath: json['profile_path'] as String);
  }
}

class Crew {
  final int id;
  final String name;
  final String job;
  final String department;
  final String profilePath;

  Crew({this.id, this.name, this.job, this.department, this.profilePath});

  factory Crew.fromJson(Map<String, dynamic> json) {
    return Crew(
        id: json['id'] as int,
        name: json['name'] as String,
        job: json['job'] as String,
        department: json['department'] as String,
        profilePath: json['profile_path'] as String);
  }
}

List<Image> getImages(Map<String, dynamic> json) {
  if (json == null || json.isEmpty) {
    return null;
  }

  var imagesList = json['backdrops'] as List;
  List<Image> images =
      imagesList.map((image) => Image.fromJson(image)).toList();

  return images;
}

class Image {
  final String backdropPath;

  Image({this.backdropPath});

  factory Image.fromJson(Map<String, dynamic> json) {
    return Image(backdropPath: json['file_path'] as String);
  }
}

List<Video> getVideos(Map<String, dynamic> json) {
  if (json == null || json.isEmpty) {
    return null;
  }
  var videosList = json['results'] as List;
  List<Video> videos =
      videosList.map((video) => Video.fromJson(video)).toList();

  return videos;
}

class Video {
  final String key;
  final String name;

  Video({this.key, this.name});

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(key: json['key'] as String, name: json['name'] as String);
  }
}

String formatDate(String date) {
  if (date == null || date.isEmpty) {
    return null;
  }

  String day = date.substring(8, 10);
  String month = date.substring(5, 7);
  if (month.startsWith('0')) {
    month = month.substring(1);
  }
  String year = date.substring(0, 4);
  String monthInLetters = _formatMonth(month);

  String formattedDate = day + ' ' + monthInLetters + ' ' + year;

  return formattedDate;
}

String _formatMonth(String month) {
  String monthInLetters = '';

  switch (month) {
    case '1':
      monthInLetters = 'January';
      break;
    case '2':
      monthInLetters = 'February';
      break;
    case '3':
      monthInLetters = 'March';
      break;
    case '4':
      monthInLetters = 'April';
      break;
    case '5':
      monthInLetters = 'May';
      break;
    case '6':
      monthInLetters = 'June';
      break;
    case '7':
      monthInLetters = 'July';
      break;
    case '8':
      monthInLetters = 'August';
      break;
    case '9':
      monthInLetters = 'September';
      break;
    case '10':
      monthInLetters = 'October';
      break;
    case '11':
      monthInLetters = 'November';
      break;
    case '12':
      monthInLetters = 'December';
      break;
  }

  return monthInLetters;
}

String formatLanguage(String language) {
  if (language == null || language.isEmpty) {
    return null;
  }
  return language == 'en' ? 'Enligsh' : 'Other';
}

List<ProductionCompany> getProductionCompanies(List<dynamic> json) {
  if (json == null || json.isEmpty) {
    return null;
  }

  List<ProductionCompany> productionCompanies =
      json.map((company) => ProductionCompany.fromJson(company)).toList();

  return productionCompanies;
}

class ProductionCompany {
  final String name;

  ProductionCompany({this.name});

  factory ProductionCompany.fromJson(Map<String, dynamic> json) {
    return ProductionCompany(name: json['name'] as String);
  }
}
