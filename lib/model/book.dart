class Book {
  String name;
  String author;
  bool seen;
  Book(this.name, this.author, this.seen);

  @override
  String toString() {
    return "$name $author";
  }

  Book.fromJson(Map<dynamic, dynamic> json)
      : name = json['name'],
        author = json['author'],
        seen = json['seen'] as bool;

  Map<String, dynamic> toJson() => {
        'name': name,
        'author': author,
        'seen': seen,
      };
}
