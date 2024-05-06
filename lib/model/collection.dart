// ignore_for_file: non_constant_identifier_names

import 'package:bookclub/model/book.dart';

class Collection {
  final int? id;
  final String? title;
  final int? owner_id;
  final String? owner;
  final String? description;
  final List<Book>? books;

  Collection({
    this.id,
    this.title,
    this.owner_id,
    this.owner,
    this.description,
    this.books,
  });

  factory Collection.fromMap(Map<String, dynamic> map) {
    return Collection(
      id: map["id"] as int?,
      title: map["title"] as String,
      owner_id: map["owner_id"] as int,
      owner: map["owner"] as String,
      description: map["description"] as String?,
      books:  map["books"] == null ? null : List<Book>.from(map["books"].map((book) => Book.fromMap(book))),
    );
  }
}
