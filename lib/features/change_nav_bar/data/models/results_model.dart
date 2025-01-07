class ResultsModel {
  bool? adult;
  String? backdropPath;
  List<int>? genreIds;
  int? id; // This is the ID you're trying to access
  String? originalLanguage;
  String? originalTitle;
  String? overview;
  double? popularity;
  String? posterPath;
  String? releaseDate;
  String? title;
  bool? video;
  double? voteAverage;
  int? voteCount;

  ResultsModel({
    this.adult,
    this.backdropPath,
    this.genreIds,
    this.id, // Ensure this field is here
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.releaseDate,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
  });

  factory ResultsModel.fromJson(Map<String, dynamic> json) {
    return ResultsModel(
      adult: json['adult'],
      backdropPath: json['backdrop_path'],
      genreIds:
          json['genre_ids'] != null ? List<int>.from(json['genre_ids']) : null,
      id: json['id'], // Make sure this is extracted from the JSON
      originalLanguage: json['original_language'],
      originalTitle: json['original_title'],
      overview: json['overview'],
      popularity: json['popularity'],
      posterPath: json['poster_path'],
      releaseDate: json['release_date'],
      title: json['title'],
      video: json['video'],
      voteAverage: json['vote_average'],
      voteCount: json['vote_count'],
    );
  }

  Map<String, dynamic> toJson() => {
        'adult': adult,
        'backdrop_path': backdropPath,
        'genre_ids': genreIds,
        'id': id, // Ensure this is included
        'original_language': originalLanguage,
        'original_title': originalTitle,
        'overview': overview,
        'popularity': popularity,
        'poster_path': posterPath,
        'release_date': releaseDate,
        'title': title,
        'video': video,
        'vote_average': voteAverage,
        'vote_count': voteCount,
      };
}
