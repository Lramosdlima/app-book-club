class Book {
  final int? id;
  final String? title;
  final String? synopsis;
  final Map? genre;
  final String? imageUrl;
  final Map? author;

  Book({
    this.id,
    this.title,
    this.synopsis,
    this.genre,
    this.imageUrl,
    this.author,
  });

  factory Book.fromMap(Map<String, dynamic> map) {
    return Book(
      id: map["id"] as int?,
      title: map["title"] as String,
      synopsis: map["synopsis"] as String,
      genre: map["genre"] as Map?,
      imageUrl: map["imageUrl"] as String?,
      author: map["author"] as Map?,
    );
  }
}
