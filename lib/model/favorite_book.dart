// ignore_for_file: non_constant_identifier_names

class FavoriteBook {
  final int? id;
  final int? user_id;
  final int? book_id;

  FavoriteBook({
    this.id,
    this.user_id,
    this.book_id,
  });

  factory FavoriteBook.fromMap(Map<String, dynamic> map) {
    return FavoriteBook(
      id: map["id"] as int?,
      user_id: map["user_id"] as int?,
      book_id: map["book_id"] as int?,
    );
  }
}
