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

  factory Book.fromMap(Map<String, dynamic> map) {
    return Book(
      id: map["id"] as int?,
      title: map["title"] as String,
      synopsis: map["synopsis"] as String,
      genre: map["genre"] as String?,
      imageUrl: map["imageUrl"] as String?,
    );
  }
}
