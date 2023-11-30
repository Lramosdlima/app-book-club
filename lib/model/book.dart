class Book {
  final int? id;
  final String? title;
  final String? synopsis;
  final String? genre;
  final String? imageUrl;

  Book({
    this.id,
    this.title,
    this.synopsis,
    this.genre,
    this.imageUrl,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json["id"] as int?,
      title: json["title"] as String,
      synopsis: json["synopsis"] as String,
      genre: json["genre"] as String?,
      imageUrl: json["imageUrl"] as String?,
    );
  }
}
