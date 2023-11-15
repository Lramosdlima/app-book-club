class Book {
  final int? id;
  final String? title;
  final String? synopsis;
  final int? genre_id;

  Book({
    this.id,
    this.title,
    this.synopsis,
    this.genre_id,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json["id"] as int?,
      title: json["title"] as String,
      synopsis: json["synopsis"] as String,
      genre_id: json["genre_id"] as int?,
    );
  }
}
