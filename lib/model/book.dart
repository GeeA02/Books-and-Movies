class Book {
  String name;
  String author;
  bool seen;
  Book(this.name, this.author, this.seen);

  @override
  String toString() {
    return "$name $author";
  }
}
