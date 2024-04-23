// ignore_for_file: avoid_print

import 'package:bookclub/model/book.dart';
import 'package:bookclub/model/response.dart';
import 'package:bookclub/util/network/http.dart';

class BookRepository {
  Future<ApiResponse> getBooks() async {
    ApiResponse response = ApiResponse();
    List books = [];
    try {
      final request = HttpHelper.get('/book/all/complete');

      await request.then((result) {
        response.status = result.data["status"];
        if (response.status == true) {
          var objects = result.data["data"];

          for (var book in objects) {
            var bookObject = Book.fromMap(book);
            books.add(bookObject);
          }

          response.data = books;
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

  Future<ApiResponse> getBookById(int id) async {
    ApiResponse response = ApiResponse();
    try {
      final request = HttpHelper.get('/book/$id');

      await request.then((result) {
        response.status = result.data["status"];
        if (response.status == true) {
          var book = Book.fromMap(result.data["data"]);

          response.data = book;
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

  Future<ApiResponse> getFavoritesBooks() async {
    ApiResponse response = ApiResponse();
    List books = [];
    try {
      final request = HttpHelper.get('/book/favorites');

      await request.then((result) {
        response.status = result.data["status"];
        if (response.status == true) {
          var objects = result.data["data"];

          for (var book in objects) {
            var bookObject = Book.fromMap(book);
            books.add(bookObject);
          }

          response.data = books;
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
