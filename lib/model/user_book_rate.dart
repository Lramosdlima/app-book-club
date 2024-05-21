// ignore_for_file: non_constant_identifier_names

import 'package:bookclub/model/book.dart';
import 'package:bookclub/model/user.dart';

class UserBookRate {
  final int? id;
  final Book? book;
  final User? user;
  final String? comment;
  final int? rate; 

  UserBookRate({
    this.id,
    this.book,
    this.user,
    this.comment,
    this.rate,
  });

  factory UserBookRate.fromMap(Map<String, dynamic> map) {
    return UserBookRate(
      id: map["id"] as int?,
      comment: map["comment"] as String?,
      rate: map["rate"] as int?,
      book: Book.fromMap(map["book"]),
      user: User.fromMap(map["user"]),
    );
  }
}