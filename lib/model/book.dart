// ignore_for_file: non_constant_identifier_names

import 'package:bookclub/model/author.dart';
import 'package:bookclub/model/genre.dart';

class Book {
  final int? id;
  final String? title;
  final String? synopsis;
  final Genre? genre;
  final String? url_image;
  final Author? author;

  Book({
    this.id,
    this.title,
    this.synopsis,
    this.genre,
    this.url_image,
    this.author,
  });

  factory Book.fromMap(Map<String, dynamic> map) {
    return Book(
      id: map["id"] as int?,
      title: map["title"] as String,
      synopsis: map["synopsis"] as String,
      genre:  map["genre"] == null ? null : Genre.fromMap(map["genre"]),
      url_image: map["url_image"] as String?,
      author: map["author"] == null ? null : Author.fromMap(map["author"]),
    );
  }
}
