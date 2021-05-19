class Movie {
  String name;
  String? director;
  int? year;
  bool seen;

  Movie(this.name, this.director, this.year, this.seen);

  @override
  String toString() {
    return "$name $director $year";
  }

  bool find(String subtext) {
    return name.toLowerCase().contains(subtext.toLowerCase());
  }

  void update(name, author, year, seen) {
    this.name = name;
    this.director = author;
    this.year = year;
    this.seen = seen;
  }

  Movie.fromJson(Map<Object?, dynamic> json)
      : name = json['name'] as String,
        director = json['director'] as String?,
        year = json['year'] as int?,
        seen = json['seen'] as bool;

  Map<String, dynamic> toJson() => {
        'name': name,
        'director': director,
        'year': year,
        'seen': seen,
      };
}
