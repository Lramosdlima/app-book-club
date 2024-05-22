// ignore_for_file: non_constant_identifier_names

import 'package:bookclub/model/book.dart';
import 'package:bookclub/model/user.dart';

class UserBookRate {
  final int? id;
  final int? book_id;
  final User? user;
  final String? comment;
  final int? rate; 
  final DateTime? created_at;

  UserBookRate({
    this.id,
    this.book_id,
    this.user,
    this.comment,
    this.rate,
    this.created_at
  });

  factory UserBookRate.fromMap(Map<String, dynamic> map) {
    return UserBookRate(
      id: map["id"] as int?,
      comment: map["comment"] as String?,
      rate: map["rate"] as int?,
      book_id: map["book_id"] as int?,
      user: User.fromMap(map["user"]),
      created_at: DateTime.parse(map["created_at"]),
    );
  }
}
