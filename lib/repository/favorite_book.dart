// ignore_for_file: avoid_print

import 'package:bookclub/model/favorite_book.dart';
import 'package:bookclub/model/response.dart';
import 'package:bookclub/util/network/http.dart';

class FavoriteBookRepository {
  Future<ApiResponse> getFavoriteBooks() async {
    ApiResponse response = ApiResponse();

    List favorites = [];

    try {
      final request = HttpHelper.get('/favorite');

      await request.then((result) {
        var objects = result.data["data"];

        for (var favorite in objects) {
          favorites.add(FavoriteBook.fromMap(favorite));
        }

        response.status = result.data["status"];
        if (response.status == true) {
          response.data = favorites;
        } else {
          response.error = result.data["error"];
        }
      }).catchError((e) {
        response.status = false;
        response.error = HttpHelper.getError(e);
        print(e);
      });

      return response;
    } catch (error) {
      print(error);
      return response;
    }
  }
}
