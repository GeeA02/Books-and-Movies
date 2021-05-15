class Movie {
  String name;
  String author;
  int year;
  bool seen;

  Movie(this.name, this.author, this.year, this.seen);

  @override
  String toString() {
    return "$name $author $year";
  }
}
