class Movie {
  String name;
  String? author;
  int? year;
  bool seen;

  Movie(this.name, this.author, this.year, this.seen);

  @override
  String toString() {
    return "$name $author $year";
  }

  Movie.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        author = json['author'],
        year = json['year'] as int?,
        seen = json['seen'] as bool;

  Map<String, dynamic> toJson() => {
        'name': name,
        'author': author,
        'year': year,
        'seen': seen,
      };
}
