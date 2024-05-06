// ignore_for_file: non_constant_identifier_names

import 'package:bookclub/model/book.dart';
import 'package:bookclub/model/user.dart';

class Interaction {
  final int? id;
  final Book? book;
  final User? user;
  final bool? already_read;
  final bool? want_to_read;
  final bool? liked;

  Interaction({
    this.id,
    this.book,
    this.user,
    this.already_read,
    this.want_to_read,
    this.liked,
  });

  factory Interaction.fromMap(Map<String, dynamic> map) {
    return Interaction(
      id: map["id"] as int?,
      already_read: map["already_read"] as bool?,
      want_to_read: map["want_to_read"] as bool?,
      liked: map["liked"] as bool?,
      book: Book.fromMap(map["book"]),
      user: User.fromMap(map["user"]),
    );
  }
}
