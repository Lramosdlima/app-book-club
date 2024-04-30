import 'package:bookclub/model/author.dart';
import 'package:bookclub/model/genre.dart';

class Book {
  final int? id;
  final String? title;
  final String? synopsis;
  final Genre? genre;
  final String? imageUrl;
  final Author? author;

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
      genre:  map["genre"] == null ? null : Genre.fromMap(map["genre"]),
      imageUrl: map["imageUrl"] as String?,
      author: map["author"] == null ? null : Author.fromMap(map["author"]),
    );
  }
}
